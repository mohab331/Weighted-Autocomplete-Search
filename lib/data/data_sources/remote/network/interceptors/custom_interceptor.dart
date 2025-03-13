import 'package:dio/dio.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/models/error_models/network_error.dart';

class CustomInterceptor extends Interceptor {
  const CustomInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept'] = 'application/json';
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    NetworkError? error = NetworkError.errorFromCode(
      options: err.requestOptions,
      statusCode: err.response?.statusCode,
      error: err,
    );
    handler.next(error);
  }
}
