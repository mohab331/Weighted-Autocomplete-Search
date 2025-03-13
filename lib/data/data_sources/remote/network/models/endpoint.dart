import 'package:equatable/equatable.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/constants/network_constants.dart';
import 'package:weighted_auto_complete_search/utils/enums/network_request_type_enum.dart';

class EndPoint extends Equatable {
  const EndPoint({
    required this.endPointPath,
    required this.requestType,
    this.queryParameters,
    this.extraHeaders,
    this.data,
  });
  final String baseURL = NetworkConst.baseURL;
  final String endPointPath;
  final NetworkRequestTypeEnum requestType;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? extraHeaders;
  final Map<String, dynamic>? data;
  String get fullUrl => baseURL + endPointPath.trim();

  @override
  List<Object?> get props => [
        data,
        baseURL,
        queryParameters,
        extraHeaders,
        endPointPath,
        requestType,
      ];
}
