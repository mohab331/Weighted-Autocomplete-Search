import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weighted_auto_complete_search/data/models/response/github_user_response_model.dart';
import 'package:weighted_auto_complete_search/presentation/screens/search/cubit/search_cubit.dart';
import 'package:weighted_auto_complete_search/presentation/screens/search/cubit/search_state.dart';
import 'package:weighted_auto_complete_search/presentation/screens/search/widgets/empty_state_widget.dart';
import 'package:weighted_auto_complete_search/presentation/screens/search/widgets/error_state_widget.dart';
import 'package:weighted_auto_complete_search/presentation/screens/search/widgets/user_profile_dialogue.dart';
import 'package:weighted_auto_complete_search/presentation/screens/search/widgets/user_tile_item.dart';

class SearchScreenContent extends StatefulWidget {
  const SearchScreenContent({super.key});

  @override
  State<SearchScreenContent> createState() => _SearchScreenContentState();
}

class _SearchScreenContentState extends State<SearchScreenContent> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SearchCubit searchCubit = context.read<SearchCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _searchController,
                onChanged: (value) {
                  context.read<SearchCubit>().searchUsers(query: value);
                },
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  hintText: "Search GitHub Users...",
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 16.h),
              if (state.hasError)
               ErrorStateWidget(
              errorMessage: state.errorModel?.errorMessage,
              onRetry: ()=> searchCubit.searchUsers(query: _searchController.text),
              )
              else if (state.isLoaded && (state.usersList?.isEmpty ?? true))
                const EmptyStateWidget(
                  message: 'No users found.',
                )
              else
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<GithubUserResponseModel>(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      value: state.selectedUser,
                      hint: Text(
                        state.isLoading
                            ? 'Loading profiles ...'
                            : 'Select a GitHub User',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                      ),
                      isExpanded: true,
                      onChanged: (GithubUserResponseModel? newUser) {
                        _onDropDownItemPressed(
                          newUser,
                        );
                      },
                      items: state.usersList
                          ?.map<DropdownMenuItem<GithubUserResponseModel>>(
                        (GithubUserResponseModel user) {
                          return DropdownMenuItem<GithubUserResponseModel>(
                            value: user,
                            enabled: !state.isLoading && !state.hasError,
                            child: UserTileItem(
                              user: user,
                            ),
                          );
                        },
                      ).toList(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.black54,
                      ),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(
                        12.r,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _onDropDownItemPressed(
    GithubUserResponseModel? newUser,
  ) {
    final SearchCubit searchCubit = context.read<SearchCubit>();
    searchCubit.onUserSelected(newUser);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: UserProfileDialogue(
            user: newUser,
          ),
        );
      },
    );
  }
}
