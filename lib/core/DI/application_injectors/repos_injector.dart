import 'package:weighted_auto_complete_search/core/DI/base_injector.dart';
import 'package:weighted_auto_complete_search/core/DI/dependency_injector.dart';
import 'package:weighted_auto_complete_search/data/data_sources/local/local_user_cache.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/services/github_user_details/github_user_details_service.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/services/search/search_service.dart';
import 'package:weighted_auto_complete_search/data/repository/search_repo_implementation.dart';
import 'package:weighted_auto_complete_search/domain/repository/base_search_repo.dart';

/// [ReposInjector] hold all application repos dependencies
class ReposInjector extends BaseInjector {
  static final reposInjectors = [
    () => diInstance.registerLazySingleton<BaseSearchRepo>(
          () => SearchRepoImplementation(
            searchService: diInstance.get<SearchService>(),
            localUserCache: diInstance.get<LocalUserCache>(),
            githubUserDetailsService:
                diInstance.get<GithubUserDetailsService>(),
          ),
        ),
  ];

  /// iterate and inject all repos
  @override
  Future<void> injectModules() async {
    for (final repoInjector in reposInjectors) {
      repoInjector.call();
    }
  }
}
