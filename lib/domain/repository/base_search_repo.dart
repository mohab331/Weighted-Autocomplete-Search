import 'package:weighted_auto_complete_search/data/models/error/app_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:weighted_auto_complete_search/data/models/request/search_request_model.dart';
import 'package:weighted_auto_complete_search/data/models/response/github_user_response_model.dart';
import 'package:weighted_auto_complete_search/data/models/response/list_response_model.dart';

abstract class BaseSearchRepo {
  Future<Either<ErrorModel, ListResponseModel<GithubUserResponseModel>>>
      search({
    required SearchRequestModel searchRequestModel,
  });
}
