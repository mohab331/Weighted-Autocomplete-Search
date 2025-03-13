import 'package:weighted_auto_complete_search/core/DI/base_injector.dart';
import 'package:weighted_auto_complete_search/core/DI/dependency_injector.dart';
import 'package:weighted_auto_complete_search/data/data_sources/local/local_user_cache.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/network_manager.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/services/github_user_details/github_user_details_service.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/services/search/search_service.dart';

class DataSourcesInjector extends BaseInjector {
  static final dataSourcesInjectors = [
    () => diInstance.registerLazySingleton<LocalUserCache>(
          () => LocalUserCache(),
        ),
    () => diInstance.registerLazySingleton<GithubUserDetailsService>(
          () => GithubUserDetailsService(
            networkManager: NetworkManager.instance,
          ),
        ),
    () => diInstance.registerLazySingleton<SearchService>(
          () => SearchService(
            networkManager: NetworkManager.instance,
          ),
        ),
  ];

  /// iterate and inject all data sources
  @override
  Future<void> injectModules() async {
    for (final dataSourceInjector in dataSourcesInjectors) {
      dataSourceInjector.call();
    }
  }
}
