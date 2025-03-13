import 'package:weighted_auto_complete_search/data/data_sources/remote/network/models/error_models/network_error_type.dart';

/// An abstract base class representing an error in the application.
///
/// This class provides a common structure for error handling, including
/// a message, stack trace, and the original error object.
abstract class ErrorModel {
  const ErrorModel({
    required this.stackTrace,
    required this.errorMessage,
    required this.error,
  });

  final String? errorMessage;
  final StackTrace? stackTrace;
  final dynamic error;
}

/// A model representing network-related errors.

class NetworkErrorModel extends ErrorModel {
  NetworkErrorModel({
    required this.statusCode,
    required this.networkErrorType,
    required super.stackTrace,
    required super.errorMessage,
    required super.error,
  });
  final int? statusCode;
  final NetworkErrorType networkErrorType;
}

/// A model representing general application errors.
class AppErrorModel extends ErrorModel {
  const AppErrorModel({
    required super.stackTrace,
    required super.errorMessage,
    required super.error,
  });
}
