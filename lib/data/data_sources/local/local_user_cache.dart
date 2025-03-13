import 'package:hive/hive.dart';
import 'package:weighted_auto_complete_search/data/data_sources/local/constants/local_constants.dart';
import 'package:weighted_auto_complete_search/data/models/response/github_user_response_model.dart';

class LocalUserCache {
  Box<dynamic>? _cachedQueryWithUsersBox;
  Box<dynamic>? _searchCountBox;
  Box<dynamic>? _cachedUserBox;
  Future<void> initHive() async {
    _cachedQueryWithUsersBox = await Hive.openBox(
      LocalStorageConstants.queryResultHiveBoxKey,
    );
    _cachedUserBox = await Hive.openBox(
      LocalStorageConstants.cachedUsersBoxKey,
    );
    _searchCountBox = await Hive.openBox(
      LocalStorageConstants.searchCountBox,
    );
  }

  List<Map<String,dynamic>>? getCachedResults(String? query) {
    final response = _cachedQueryWithUsersBox
        ?.get(query?.toLowerCase().trim(),);
    return response;
  }

  Future<void> cacheQueryResults(
      String? query, List<GithubUserResponseModel> users) async {
    await _cachedQueryWithUsersBox?.put(
      query?.toLowerCase().trim(),
      users
          .map(
            (githubUser) => githubUser.toJson(),
          )
          .toList(),
    );
  }

  Future<void> cacheUser(GithubUserResponseModel? user) async {
    await _cachedUserBox?.put(
      user?.userName?.toLowerCase().trim(),
      user?.toJson(),
    );
  }
  Map<String,dynamic>? getCachedUser(String? query)  {
    return _cachedUserBox?.get(
      query?.toLowerCase().trim(),
     );
  }

  int getSearchCount(String? query) {
    return _searchCountBox?.get(query?.toLowerCase().trim(),) ?? 0;
  }

  Future<void> updateSearchCount(String? query, int count) async {
    await _searchCountBox?.put(query?.toLowerCase().trim(), count);
  }
}
