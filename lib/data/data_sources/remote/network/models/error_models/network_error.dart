import 'package:dio/dio.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/models/error_models/network_error_type.dart';

class NetworkError extends DioException {
  NetworkError({
    required super.requestOptions,
    required this.errorType,
    required this.errorMessage,
    super.error,
  });

  factory NetworkError.errorFromCode({
    required int? statusCode,
    dynamic error,
    String? errorMessage,
    RequestOptions? options,
  }) {
    final errorType = NetworkErrorType.getType(statusCode);
    return NetworkError(
      requestOptions: options ?? RequestOptions(),
      error: error,
      errorType: errorType,
      errorMessage: errorMessage ?? errorType.getErrorMessage(),
    );
  }
  final NetworkErrorType errorType;
  final String? errorMessage;
}
