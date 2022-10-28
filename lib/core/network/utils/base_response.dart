enum ErrorType { timeout, noConnection, apiFailure, localError, unknown }

String getMessageFromErrorType(ErrorType type, String? code) {
  switch (type) {
    case ErrorType.timeout:
      return "Timeout error occurred, please try again";
    case ErrorType.noConnection:
      return "Could not connect to the server, please check your network";
    case ErrorType.apiFailure:
      switch (code) {
        default:
          return "Some error occurred, please try again";
      }
    case ErrorType.localError:
      return "Some error occurred, please try again";
    default:
      return "Unknown error occurred, please try again";
  }
}

class ApiError {
  final ErrorType type;
  final String code;
  final String message;

  ApiError(this.type, {this.code = "", this.message = ""});
}

class ApiResponse<T> {
  final T data;

  ApiResponse(this.data);
}
