import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

final Logger logger = Logger(
  printer: PrettyPrinter(
    lineLength: 1000,
    methodCount: 0,
    errorMethodCount: 5,
    printEmojis: false,
    noBoxingByDefault: true,
    colors: true,
  ),
);

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String formattedHeaders = _formatJson(options.headers);
    String formattedBody = _formatJson(options.data);

    logger.i('''
Request:
Time: ${_formattedDate()}
Method: ${options.method}
URL: ${options.uri}
Headers: $formattedHeaders
Request Body: $formattedBody
''');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String formattedBody = _formatJson(response.data);

    logger.i('''
Response:
Time: ${_formattedDate()}
Method: ${response.requestOptions.method}
URL: ${response.requestOptions.uri}
Status Code: ${response.statusCode}
Response Body: $formattedBody
''');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorResponse = err.response != null
        ? _formatJson(err.response?.data)
        : "No Response Data";

    logger.e('''
Error:
Time: ${_formattedDate()}
Method: ${err.requestOptions.method}
URL: ${err.requestOptions.uri}
Status Code: ${err.response?.statusCode ?? 'Unknown'}
Error Message: ${err.error}
Response: $errorResponse
''');

    handler.next(err);
  }

  String _formattedDate() {
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());
  }

  String _formatJson(dynamic data) {
    try {
      if (data == null) return "Empty";
      if (data is String) return data;
      return const JsonEncoder.withIndent('  ').convert(data);
    } catch (_) {
      return data.toString();
    }
  }
}
