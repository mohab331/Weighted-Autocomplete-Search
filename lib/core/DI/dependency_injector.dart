import 'package:get_it/get_it.dart';
import 'package:weighted_auto_complete_search/core/DI/injector_holder.dart';

final GetIt diInstance = GetIt.instance;
class DependencyInjector {
  DependencyInjector() : super();
  Future<void> injectModules() async {
    InjectorHolder.injectAllApplicationModules();
  }
}
