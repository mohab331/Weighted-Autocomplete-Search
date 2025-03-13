/// contains any network error associated with its [statusCode]
enum NetworkErrorType {
  badRequest(400),
  unauthorized(401),
  forbidden(403),
  notFound(404),
  conflict(409),
  badCertificate(495),
  internalServerError(500),
  noInternetConnection(503),
  unknown(-1); // Added unknown for undefined error codes

  final int statusCode;
  const NetworkErrorType(this.statusCode);
  static NetworkErrorType getType(int? code) {
    switch (code) {
      case 400:
        return NetworkErrorType.badRequest;
      case 401:
        return NetworkErrorType.unauthorized;
      case 403:
        return NetworkErrorType.forbidden;
      case 404:
        return NetworkErrorType.notFound;
      case 409:
        return NetworkErrorType.conflict;
      case 495:
        return NetworkErrorType.badCertificate;
      case 500:
        return NetworkErrorType.internalServerError;
      case 503:
        return NetworkErrorType.noInternetConnection;
      default:
        return NetworkErrorType.unknown;
    }
  }

  String getErrorMessage() {
    switch (this) {
      case NetworkErrorType.badRequest:
        return 'Oops! Something went wrong with your request. Please check the details and try again.';
      case NetworkErrorType.unauthorized:
        return 'It looks like you need to log in to access this. Please sign in and try again.';
      case NetworkErrorType.forbidden:
        return 'You do not have permission to access this resource. If you believe this is an error, please contact support.';
      case NetworkErrorType.notFound:
        return 'We couldn’t find what you’re looking for. Please check the URL or try again later.';
      case NetworkErrorType.conflict:
        return 'There seems to be a conflict with your request. Please check for any conflicts and try again.';
      case NetworkErrorType.badCertificate:
        return 'There’s an issue with the connection’s security certificate. Please try again later or check your network settings.';
      case NetworkErrorType.internalServerError:
        return 'Something went wrong on our end. We’re working on it! Please try again in a moment.';
      case NetworkErrorType.noInternetConnection:
        return 'No internet connection detected. Please check your network settings and try again.';
      case NetworkErrorType.unknown:
        return 'An unexpected issue occurred. Please try again or contact support if the problem persists.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
