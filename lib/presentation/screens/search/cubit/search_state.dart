import 'package:weighted_auto_complete_search/data/models/error/app_errors.dart';
import 'package:weighted_auto_complete_search/data/models/response/github_user_response_model.dart';

import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  final List<GithubUserResponseModel>? usersList;
  final ErrorModel? errorModel;
  final bool isLoading;
  final bool hasError;

  final bool isLoaded;
  final GithubUserResponseModel? selectedUser;

  const SearchState._({
    this.usersList,
    this.errorModel,
    this.isLoading = false,
    this.hasError = false,
    this.selectedUser,
    this.isLoaded = false,
  });

  const SearchState.initial() : this._();

  const SearchState.loading() : this._(isLoading: true);

  const SearchState.loaded({
    required List<GithubUserResponseModel> users,
    GithubUserResponseModel? user,
  }) : this._(
          usersList: users,
          selectedUser: user,
          isLoaded: true,
        );

  const SearchState.error(ErrorModel error)
      : this._(
          errorModel: error,
          hasError: true,
        );

  @override
  List<Object?> get props => [
        usersList,
        errorModel,
        isLoading,
        hasError,
        selectedUser,
        isLoaded,
      ];
}
