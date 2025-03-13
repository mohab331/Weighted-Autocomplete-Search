import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighted_auto_complete_search/data/models/error/app_errors.dart';
import 'package:weighted_auto_complete_search/data/models/request/search_request_model.dart';
import 'package:weighted_auto_complete_search/data/models/response/github_user_response_model.dart';
import 'package:weighted_auto_complete_search/domain/repository/base_search_repo.dart';
import 'package:weighted_auto_complete_search/presentation/screens/search/cubit/search_state.dart';
import 'package:weighted_auto_complete_search/utils/constants/app_constants.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required BaseSearchRepo searchRepo,
  })  : _searchRepo = searchRepo,
        super(const SearchState.initial());
  final BaseSearchRepo _searchRepo;
  Timer? _debounce;
  Future<void> searchUsers({
    required String? query,
  }) async {
    if (query?.isEmpty ?? true) {
      emit(
        const SearchState.loaded(users: []),
      );
      return;
    }

    /// Assuming that search should start after 2nd character
    if ((query?.length ?? 0) < 3) return;

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      AppConstants.searchDelayTimer,
      () => _handleSearch(query),
    );
  }

  Future<void> _handleSearch(String? searchQuery) async {
    try {
      emit(const SearchState.loading());
      final response = await _searchRepo.search(
        searchRequestModel: SearchRequestModel(
          query: searchQuery,
        ),
      );
      response.fold(
        (errorModel) {
          emit(
            SearchState.error(
              errorModel,
            ),
          );
        },
        (searchItemsResponseList) async {
          final sortedUsersList =
              _sortedUsersList(searchItemsResponseList.items);
          emit(
            SearchState.loaded(
              users: sortedUsersList,
            ),
          );
          ;
        },
      );
    } on Exception catch (e, stackTrace) {
      emit(
        SearchState.error(
          AppErrorModel(
            errorMessage: e.toString(),
            error: e,
            stackTrace: stackTrace,
          ),
        ),
      );
    }
  }

  /// Sorts a list of GitHub users based on repository count and recent activity.
  ///
  ///  Sorting Criteria:
  ///
  /// 1. **Users with 50 or more public repositories are prioritized.**
  ///    - If one user has 50+ repositories and the other does not, the user with more repositories is ranked higher.
  ///
  /// 2. **Among users with 50+ repositories, recent activity is considered.**
  ///    - A user is considered **active** if their `updatedAt` date is within the last 6 months.
  ///    - If one user is active and the other is not, the active user is ranked higher.
  ///
  /// 3. **If two users have the same status (both have 50+ repositories or both have fewer than 50), their original order is preserved.**
  List<GithubUserResponseModel> _sortedUsersList(
    List<GithubUserResponseModel>? usersList,
  ) {
    if (usersList?.isEmpty ?? true) return [];
    final sixMonthsAgo = DateTime.now().subtract(const Duration(days: 180));
    final sortedList = List<GithubUserResponseModel>.from(
      usersList ?? [],
    );
    sortedList.sort(
      (userA, userB) {
        final hasUserA50OrMoreRepos = (userA.publicReposCount ?? 0) >= 50;
        final hasUserB50OrMoreRepos = (userB.publicReposCount ?? 0) >= 50;

        final isUserAActive = userA.updatedAt?.isAfter(sixMonthsAgo) ?? false;
        final isUserBActive = userB.updatedAt?.isAfter(sixMonthsAgo) ?? false;

        if (hasUserA50OrMoreRepos && !hasUserB50OrMoreRepos) return -1;
        if (hasUserB50OrMoreRepos && !hasUserA50OrMoreRepos) return 1;

        if (hasUserA50OrMoreRepos && hasUserB50OrMoreRepos) {
          if (isUserAActive && !isUserBActive) return -1;
          if (isUserBActive && !isUserAActive) return 1;
        }
        return 0;
      },
    );
    return sortedList;
  }

  void onUserSelected(GithubUserResponseModel? selectedUser) {
    emit(
      SearchState.loaded(
        users: state.usersList ?? [],
        user: selectedUser,
      ),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
