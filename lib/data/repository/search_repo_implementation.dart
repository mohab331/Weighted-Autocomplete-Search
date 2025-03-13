import 'package:dartz/dartz.dart';
import 'package:weighted_auto_complete_search/data/data_sources/local/local_user_cache.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/models/error_models/network_error.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/models/error_models/network_error_type.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/services/github_user_details/github_user_details_service.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/services/search/search_service.dart';
import 'package:weighted_auto_complete_search/data/models/error/app_errors.dart';
import 'package:weighted_auto_complete_search/data/models/request/search_request_model.dart';
import 'package:weighted_auto_complete_search/data/models/response/github_user_response_model.dart';
import 'package:weighted_auto_complete_search/data/models/response/list_response_model.dart';
import 'package:weighted_auto_complete_search/domain/repository/base_search_repo.dart';
import 'package:weighted_auto_complete_search/utils/constants/app_constants.dart';
import 'package:weighted_auto_complete_search/utils/helpers/helper_functions.dart';
import 'package:weighted_auto_complete_search/utils/helpers/operation_handler.dart';

class SearchRepoImplementation implements BaseSearchRepo {
  SearchRepoImplementation({
    required SearchService searchService,
    required LocalUserCache localUserCache,
    required GithubUserDetailsService githubUserDetailsService,
  })  : _searchService = searchService,
        _localUserCache = localUserCache,
        _githubUserDetailsService = githubUserDetailsService;

  final SearchService _searchService;
  final LocalUserCache _localUserCache;

  final GithubUserDetailsService _githubUserDetailsService;

  /// Searches for GitHub users based on the provided [searchRequestModel].
  ///
  /// - If offline, it attempts to return cached results.
  /// - If the search query is frequently searched, it checks the cache first.
  /// - Otherwise, it fetches results from the API and caches them.
  ///
  @override
  Future<Either<ErrorModel, ListResponseModel<GithubUserResponseModel>>>
      search({
    required SearchRequestModel searchRequestModel,
  }) async {
    return await OperationHandler.executeWithHandling<
        ListResponseModel<GithubUserResponseModel>>(
      () async {
        final bool isOffline = !(await hasInternetConnection());
        if (isOffline) {
          return _handleOfflineSearch(searchRequestModel.query);
        }

        final searchCount =
            _localUserCache.getSearchCount(searchRequestModel.query);
        await _localUserCache.updateSearchCount(
            searchRequestModel.query, searchCount + 1);

        if (_isFrequentlySearched(searchCount)) {

          final cachedResults =
              _localUserCache.getCachedResults(searchRequestModel.query);

          if (cachedResults?.isNotEmpty ?? false) {
            return ListResponseModel.fromJson(
              cachedResults,
              (searchItem) => GithubUserResponseModel.fromJson(searchItem),
            );
          }
        }

        final searchResponse =
            await _searchService.search(searchModel: searchRequestModel);
        final searchListResponseModel =
            ListResponseModel<GithubUserResponseModel>.fromJson(
          searchResponse.payload['items'],
          (searchItem) => GithubUserResponseModel.fromJson(searchItem),
        );

        final usersWithDetails =
            await _fetchUserDetails(searchListResponseModel.items);

        _localUserCache.cacheQueryResults(searchRequestModel.query, usersWithDetails);

        return ListResponseModel(items: usersWithDetails);
      },
    );
  }


  ListResponseModel<GithubUserResponseModel> _handleOfflineSearch(
      String? query) {
    final cachedResults = _localUserCache.getCachedResults(query);
    if (cachedResults?.isEmpty ?? true) {
      throw NetworkError.errorFromCode(
        statusCode: NetworkErrorType.noInternetConnection.statusCode,
      );
    }
    return ListResponseModel.fromJson(
      cachedResults,
      (searchItem) => GithubUserResponseModel.fromJson(searchItem),
    );
  }

  bool _isFrequentlySearched(int searchCount) {
    return searchCount > AppConstants.frequentSearchCount;
  }


  /// Fetches detailed information for the first 10 GitHub users in the list.
  Future<List<GithubUserResponseModel>> _fetchUserDetails(
      List<GithubUserResponseModel> users) async {
    final usersWithDetails = <GithubUserResponseModel>[];

    for (final user in users.take(10).toList()) {
      final userDetails = await _getUserDetails(user);
      usersWithDetails.add(userDetails);
    }

    return usersWithDetails;
  }


  /// Retrieves user details either from cache or by making an API request.
  ///
  /// If the user is frequently searched, it checks the cache first.
  /// Otherwise, it fetches the details from the API and updates the cache.
  Future<GithubUserResponseModel> _getUserDetails(
      GithubUserResponseModel user) async {
    final searchCount = _localUserCache.getSearchCount(user.userName);

    if (_isFrequentlySearched(searchCount)) {
      final cachedUser = _localUserCache.getCachedUser(user.userName);
      if (cachedUser?.isNotEmpty ?? false) {
        return GithubUserResponseModel.fromJson(cachedUser!);
      }
    }

    final userResponse = await _githubUserDetailsService
        .getUserDetailsByUserName(userName: user.userName);
    final userDetailsModel =
        GithubUserResponseModel.fromJson(userResponse.payload);

    await _localUserCache.updateSearchCount(user.userName, searchCount + 1);
    if (_isFrequentlySearched((searchCount + 1))) {
      await _localUserCache.cacheUser(userDetailsModel);
    }

    return userDetailsModel;
  }
}
