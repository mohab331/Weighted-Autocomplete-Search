import 'package:dartz/dartz.dart';
import 'package:weighted_auto_complete_search/data/data_sources/remote/network/models/error_models/network_error.dart';
import 'package:weighted_auto_complete_search/data/models/error/app_errors.dart';

/// A utility class for handling operations with standardized error handling.
///
/// This class provides a method to execute asynchronous operations safely,
/// catching and wrapping exceptions into error models.
class OperationHandler {
  static Future<Either<ErrorModel, T>> executeWithHandling<T>(
    Future<T> Function() operation,
  ) async {
    try {
      final result = await operation();
      return Right(result);
    } on NetworkError catch (e) {
      return Left(
        NetworkErrorModel(
          errorMessage: e.errorMessage,
          stackTrace: e.stackTrace,
          error: e,
          networkErrorType: e.errorType,
          statusCode: e.errorType.statusCode,
        ),
      );
    } on Exception catch (e) {
      return Left(
        AppErrorModel(
          error: e,
          stackTrace: StackTrace.current,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
