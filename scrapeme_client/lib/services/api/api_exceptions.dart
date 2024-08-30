abstract class APIExceptions implements Exception {
  APIExceptions({this.message, this.prefix, this.url});
  final String? message;
  final String? prefix;
  final String? url;
}

class FetchDataException extends APIExceptions {
  FetchDataException([String? message, String? url])
      : super(message: message, prefix: 'Unable to process', url: url);
}

class BadRequestException extends APIExceptions {
  BadRequestException([String? message, String? url])
      : super(message: message, prefix: 'Bad Request', url: url);
}

class UnAuthorizedException extends APIExceptions {
  UnAuthorizedException([String? message, String? url])
      : super(message: message, prefix: 'Unauthorized', url: url);
}

class MaxRetryLimitReachedException extends APIExceptions {
  MaxRetryLimitReachedException([String? message, String? url])
      : super(message: message, prefix: message, url: url);
}

class TooManyRequestsException extends APIExceptions {
  TooManyRequestsException([String? message, String? url])
      : super(message: message, prefix: 'Too Many Requests', url: url);
}

class RefreshTokenExpiredException extends APIExceptions {
  RefreshTokenExpiredException([String? message, String? url])
      : super(message: message, prefix: 'Refresh Token Expired', url: url);
}