import 'package:weighted_auto_complete_search/data/data_sources/remote/network/models/endpoint.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/models/network_response.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/network_manager.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/services/github_user_details/constants/github_user_details_endpoints.dart';
import 'package:weighted_auto_complete_search/utils/enums/network_request_type_enum.dart';

class GithubUserDetailsService {
  GithubUserDetailsService({
    required NetworkManager networkManager,
  }) : _networkManager = networkManager;
  final NetworkManager _networkManager;

  Future<NetworkResponse> getUserDetailsByUserName({
    required String? userName,
  }) async =>
      _networkManager.request(
        endpoint: EndPoint(
          endPointPath: GithubUserDetailsEndpoints.userDetailsEndpoint(
            userName: userName,
          ),
          requestType: NetworkRequestTypeEnum.GET,
        ),
      );
}
