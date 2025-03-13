import 'package:weighted_auto_complete_search/data/data_sources/remote/network/models/endpoint.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/models/network_response.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/network_manager.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/services/search/constants/search_endpoints.dart';
import 'package:weighted_auto_complete_search/data/models/request/search_request_model.dart';
import 'package:weighted_auto_complete_search/utils/enums/network_request_type_enum.dart';

class SearchService {
  SearchService({
    required NetworkManager networkManager,
  }) : _networkManager = networkManager;
  final NetworkManager _networkManager;

  Future<NetworkResponse> search({
    required SearchRequestModel searchModel,
  }) async =>
      _networkManager.request(
        endpoint: EndPoint(
          endPointPath: SearchEndpoints.searchUserEndpoint,
          requestType: NetworkRequestTypeEnum.GET,
          queryParameters: searchModel.toJson(),
        ),
      );
}
