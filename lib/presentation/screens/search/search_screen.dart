import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighted_auto_complete_search/core/DI/dependency_injector.dart';
import 'package:weighted_auto_complete_search/data/data_sources/local/local_user_cache.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/network_manager.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/services/github_user_details/github_user_details_service.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/services/search/search_service.dart';
import 'package:weighted_auto_complete_search/data/repository/search_repo_implementation.dart';
import 'package:weighted_auto_complete_search/domain/repository/base_search_repo.dart';
import 'package:weighted_auto_complete_search/presentation/screens/search/cubit/search_cubit.dart';
import 'package:weighted_auto_complete_search/presentation/screens/search/search_screen_content.dart';
import 'package:weighted_auto_complete_search/utils/constants/app_constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConstants.appTitle,
        ),
      ),
      body: BlocProvider<SearchCubit>(
        create: (context) => SearchCubit(
          searchRepo: diInstance.get<BaseSearchRepo>(),
        ),
        child: const SearchScreenContent(),
      ),
    );
  }
}
