import 'package:dio/dio.dart';
import 'package:testscout/services/services.dart';
import 'package:testscout/utils/custom_log.dart';

class BaseInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // logg.d('REQUEST[${options.method}] => PATH: ${options.path}');
    final token = 'Bearer ${Prefs.token}';
    options.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    });
    logg.d('token $token');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final out =
        'RESULT\t>> ${response.statusCode} : ${response.requestOptions.method}'
        '\nURL\t\t>> ${response.requestOptions.uri}'
        '\nPARAMS\t>> ${response.requestOptions.queryParameters}'
        // '\nBODY\t>> ${response.requestOptions.data}'
        '\nBODY\t>> ${(response.requestOptions.data as FormData?)?.fields}'
        '\nDATA\t>> ${response.data}';
    logg.d(out);
    logg.dev(response.data, json: true);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final out =
        'ERROR\t>> ${err.response?.statusCode} : ${err.requestOptions.method}'
        '\nURL\t\t>> ${err.requestOptions.uri}'
        '\nPARAMS\t>> ${err.requestOptions.queryParameters}'
        // '\nBODY\t>> ${err.requestOptions.data}'
        '\nBODY\t>> ${(err.requestOptions.data as FormData?)?.fields}'
        '\nDATA\t>> ${err.response?.data}';
    logg.d(out);
    logg.dev(out);
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err);
          case 401:
            throw UnauthorizedException(err);
          case 404:
            throw NotFoundException(err);
          case 409:
            throw ConflictException(err);
          case 500:
            throw InternalServerErrorException(err);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException(err);
    }

    return handler.next(err);
  }
}

class BadRequestException extends DioError {
  BadRequestException(this.r) : super(requestOptions: r.requestOptions);

  final DioError r;

  @override
  String toString() {
    return (r.response?.data as Map?)?['message'] ?? 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(this.r)
      : super(requestOptions: r.requestOptions);

  final DioError r;

  @override
  String toString() {
    var result = 'Unknown error occurred, please try again later.';
    if (r.response?.data is Map) {
      result = (r.response!.data as Map)['message'] ?? '';
    }
    return result;
  }
}

class ConflictException extends DioError {
  ConflictException(this.r) : super(requestOptions: r.requestOptions);

  final DioError r;

  @override
  String toString() {
    return (r.response?.data as Map?)?['message'] ?? 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(this.r, {this.code = 401})
      : super(requestOptions: r.requestOptions);

  final DioError r;
  final int code;

  @override
  String toString() {
    return (r.response?.data as Map?)?['message'] ?? 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(this.r) : super(requestOptions: r.requestOptions);

  final DioError r;

  @override
  String toString() {
    return (r.response?.data as Map?)?['message'] ??
        'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(this.r)
      : super(requestOptions: r.requestOptions);

  final DioError r;

  @override
  String toString() {
    return (r.response?.data as Map?)?['message'] ??
        'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(this.r) : super(requestOptions: r.requestOptions);

  final DioError r;

  @override
  String toString() {
    return (r.response?.data as Map?)?['message'] ??
        'The connection has timed out, please try again.';
  }
}
