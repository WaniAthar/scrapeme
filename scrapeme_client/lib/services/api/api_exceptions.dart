abstract class APIExceptions implements Exception {
  APIExceptions({this.message, this.prefix, this.url});
  final String? message;
  final String? prefix;
  final String? url;
}

class FetchDataException extends APIExceptions {
  FetchDataException([String? message, String? url])
      : super(message: message, prefix: 'Unable to process', url: url);

  @override
  String toString() {
    return 'FetchDataException{message: $message, prefix: $prefix, url: $url}';
  }
}

class BadRequestException extends APIExceptions {
  BadRequestException([String? message, String? url])
      : super(message: message, prefix: 'Bad Request', url: url);

  @override
  String toString() {
    return 'BadRequestException{message: $message, prefix: $prefix, url: $url}';
  }
}

class UnAuthorizedException extends APIExceptions {
  UnAuthorizedException([String? message, String? url])
      : super(message: message, prefix: 'Unauthorized', url: url);

  @override
  String toString() {
    return 'UnAuthorizedException{message: $message, prefix: $prefix, url: $url}';
  }
}

class MaxRetryLimitReachedException extends APIExceptions {
  MaxRetryLimitReachedException([String? message, String? url])
      : super(message: message, prefix: message, url: url);

  @override
  String toString() {
    return 'MaxRetryLimitReachedException{message: $message, prefix: $prefix, url: $url}';
  }
}

class TooManyRequestsException extends APIExceptions {
  TooManyRequestsException([String? message, String? url])
      : super(message: message, prefix: 'Too Many Requests', url: url);

  @override
  String toString() {
    return 'TooManyRequestsException{message: $message, prefix: $prefix, url: $url}';
  }
}

class RefreshTokenExpiredException extends APIExceptions {
  RefreshTokenExpiredException([String? message, String? url])
      : super(message: message, prefix: 'Refresh Token Expired', url: url);

  @override
  String toString() {
    return 'RefreshTokenExpiredException{message: $message, prefix: $prefix, url: $url}';
  }
}
