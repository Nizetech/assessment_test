import 'package:assessment_test/helper/toast.dart';
import 'package:assessment_test/utils/app_logger.dart';
import 'package:assessment_test/utils/exception.dart';
import 'package:assessment_test/utils/failure.dart';
import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  AppInterceptors(this.dio);
  final _log = appLogger(AppInterceptors);
  final Dio dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // checkStatusCode(response.requestOptions, response);
    // print(÷.realUri);

    _log.custom(
      "--------- Calling Api [${DateTime.now()}]----------",
      color: LoggerColor.darkGrey,
      functionName: "onRequest",
    );
    _log.custom(
      "${options.method}: ${options.path}",
      color: LoggerColor.darkGrey,
      functionName: "onRequest",
    );
    _log.custom(
      options.uri,
      color: LoggerColor.darkGrey,
      functionName: "onRequest",
    );
    return handler.next(options);
  }

  @override
  Future<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    checkStatusCode(response.requestOptions, response);

    _log.custom(
      "--------- Api Response [${DateTime.now()}]----------",
      color: LoggerColor.darkGrey,
      functionName: "onResponse",
    );
    _log.custom(
      response.requestOptions.uri,
      color: LoggerColor.darkGrey,
      functionName: "onResponse",
    );
    return handler.next(response);
  }

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    _log.e(err.requestOptions.headers, functionName: "onError[1]");
    _log.e(err.requestOptions.data, functionName: "onError[2]");
    _log.e(err.response?.data, functionName: "onError[3]");
    ErrorToast(message: err.response?.data.toString() ?? "");
    _log.e(err.response?.statusCode, functionName: "onError[4]");

    switch (err.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        // reasign err variable
        err = DeadlineExceededException(err.requestOptions);
        break;
      case DioErrorType.connectionError:
      case DioErrorType.badResponse:
        try {
          checkStatusCode(err.requestOptions, err.response);
        } on DioError catch (failure) {
          // reasign err variable
          err = failure;
        }

        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.badCertificate:
        err = BadCertificateException(err.requestOptions);
        break;
      case DioErrorType.unknown:
        _log.e(err.message, functionName: "onError[other]");
        err = NoInternetConnectionException(err.requestOptions);
    }
    //continue
    return handler.next(err);
  }

  void checkStatusCode(RequestOptions requestOptions, Response? response) {
    try {
      switch (response?.statusCode) {
        case 200:
        case 204:
        case 201:
        case 202:
          break;
        case 400:
          throw BadRequestException(requestOptions, response);
        case 401:
          throw UnauthorizedException(requestOptions, response);
        case 404:
          throw NotFoundException(requestOptions);
        case 409:
          throw ConflictException(requestOptions, response);
        case 500:
          throw InternalServerErrorException(requestOptions);
        default:
          _log.e(response?.data, functionName: "onError[checkStatusCode]");
          _log.e(
            response?.statusCode,
            functionName: "onError[checkStatusCode]",
          );
          throw ServerCommunicationException(response);
      }
    } on Failure {
      rethrow;
    }
  }
}
