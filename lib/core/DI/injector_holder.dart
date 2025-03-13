import 'package:weighted_auto_complete_search/core/DI/application_injectors/data_sources_injector.dart';
import 'package:weighted_auto_complete_search/core/DI/application_injectors/repos_injector.dart';
import 'package:weighted_auto_complete_search/core/DI/base_injector.dart';

class InjectorHolder {
  static final List<BaseInjector> _applicationInjectors = [
    DataSourcesInjector(),
    ReposInjector(),
  ];

  /// iterate and inject all application modules
  static void injectAllApplicationModules() {
    for (var injector in _applicationInjectors) {
      injector.injectModules();
    }
  }
}
