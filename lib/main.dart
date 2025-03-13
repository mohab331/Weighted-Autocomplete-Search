import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weighted_auto_complete_search/core/DI/dependency_injector.dart';
import 'package:weighted_auto_complete_search/data/data_sources/local/local_user_cache.dart';
import 'package:weighted_auto_complete_search/presentation/screens/search/search_screen.dart';
import 'package:weighted_auto_complete_search/utils/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weighted_auto_complete_search/utils/observers/app_bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Hive.initFlutter();
  await DependencyInjector().injectModules();
  await diInstance.get<LocalUserCache>().initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) => MaterialApp(
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(
                1.0,
              ),
            ),
            child: child ?? const Placeholder(),
          );
        },
        debugShowCheckedModeBanner: kDebugMode,
        scrollBehavior: const ScrollBehavior().copyWith(
          physics: const BouncingScrollPhysics(),
        ),
        title: AppConstants.appTitle,
        home: const MyHomePage(),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          hintColor: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            color: Colors.blue,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
            surface: Colors.white,
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(
                12.r,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(
                12.r,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(
                12.r,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(
                12.r,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(
                12.r,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(
                12.r,
              ),
            ),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.0.w,
              vertical: 12.0.h,
            ),
            errorMaxLines: 3,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const SearchScreen();
  }
}
