import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/constants/network_constants.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/interceptors/custom_interceptor.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/interceptors/logger_interceptor.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/models/endpoint.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/models/error_models/network_error.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/models/error_models/network_error_type.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/models/network_response.dart';
import 'package:weighted_auto_complete_search/utils/helpers/helper_functions.dart';

class NetworkManager {
  NetworkManager._internal();

  static final NetworkManager instance = NetworkManager._internal();
  final Dio _dio = Dio()
    ..options = BaseOptions(
      baseUrl: NetworkConst.baseURL,
      connectTimeout: const Duration(
        seconds: NetworkConst.timeout,
      ),
      contentType: HeaderConst.jsonContentType,
      responseType: ResponseType.json,
    )
    ..interceptors.addAll([
      LoggerInterceptor(),
      const CustomInterceptor(),
    ]);

  Future<NetworkResponse> request<T>({
    required EndPoint endpoint,
  }) async {
    try {
      if (!(await hasInternetConnection())) {
        throw NetworkError.errorFromCode(
          statusCode: NetworkErrorType.noInternetConnection.statusCode,
        );
      }
      final response = await _dio.request(
        endpoint.fullUrl,
        queryParameters: endpoint.queryParameters,
        data: endpoint.data,
        options: Options(
          method: endpoint.requestType.value,
          extra: endpoint.extraHeaders,
        ),
      );
      final bool isSuccess = (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300);
      return NetworkResponse(
        payload: response.data,
        message: response.statusMessage,
        success: isSuccess,
      );
    } on SocketException catch (e) {
      throw NetworkError.errorFromCode(
        statusCode: NetworkErrorType.noInternetConnection.statusCode,
        error: e,
      );
    } on NetworkError catch (e) {
      logger.d(
        'Error Message: ${e.errorMessage}'
        '\nError Type: ${e.errorType}'
        '\nError: ${e.error}'
        '\nError: ${e.stackTrace}',
      );
      rethrow;
    } on Exception catch (e, s) {
      logger.d(
        'Error Message: ${e.toString()}'
        '\nError Type: ${e.runtimeType}'
        '\nError: $e'
        '\nStackTrace: $s',
      );
      rethrow;
    }
  }
}
