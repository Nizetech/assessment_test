import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:assessment_test/constant/api_constant.dart';
import 'package:assessment_test/utils/network_interceptors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';

enum FormDataType { post, patch, put }

class NetworkClient {
  factory NetworkClient() => _singleton;
  NetworkClient._internal();
  static final _singleton = NetworkClient._internal();

  // late final LocalCache _localCache = LocalCacheImpl ();

  final Dio _dio = createDio();
// ======================================================
//================== Dio Initialization =================
//=======================================================

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiRoute.baseUrl,
        receiveTimeout: const Duration(milliseconds: 40000), // 15 seconds
        connectTimeout: const Duration(milliseconds: 40000),
        sendTimeout: const Duration(milliseconds: 40000),
      ),
    );

    // dio.interceptors.addAll({
    //   AppInterceptors(dio),
    // });
    return dio;
  }

  Map<String, String> get _getAuthHeader {
    const token = '';
    //TODO uncomment this line when you want to use auth header
    //! LocalCacheImpl().getToken();
    //  LocalCacheImpl().getToken();
    if (token.isNotEmpty) {
      return {
        "Authorization": "Bearer $token",
      };
    }

    print("====== GetAuthHeader ======");
    print(token);

    return {};
  }

// ======================================================
//======================== Get ==========================
//=======================================================
  ///get request
  Future<T?> get<T>(
    /// the api route path without the base url
    ///
    String uri, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> requestHeaders = const {},
    // Options options,
    CancelToken? cancelToken,
    String? token,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,

        //! TODO uncomment this line when you want to use auth header
        options: Options(headers: {..._getAuthHeader, ...requestHeaders}),
      );

      return response.data as T;
    } on PlatformException {
      rethrow;
    }
  }

// ======================================================
//======================== POST ==========================
//=======================================================
  ///Post request
  Future<dynamic> post(
    /// the api route without the base url
    String uri, {
    ///this are query parameters that would
    /// be attached to the url
    /// [e.g]=>{"a":"yes"}
    /// https://she.com/getPeople?a=yes
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> requestHeaders = const {},
    Object? body,
    String? token,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: {..._getAuthHeader, ...requestHeaders},
        ),
      );

      print(response.headers.value('token'));

      log(response.statusCode.toString());
      return response.data;
    } on PlatformException {
      rethrow;
    }
  }

// ======================================================
//======================== PUT ==========================
//=======================================================
  ///Put Request
  Future<T?> put<T>(
    /// the api route without the base url
    String uri, {
    ///this are query parameters that would
    /// be attached to the url
    /// [e.g]=>{"a":"yes"}
    /// she.com/getPeople?a=yes
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> requestHeaders = const {},
    Object body = const {},
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        uri,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: {..._getAuthHeader, ...requestHeaders},
        ),
      );
      return response.data as T;
    } on PlatformException {
      rethrow;
    }
  }

  Future<T?> patch<T>(
    /// the api route without the base url
    String uri, {
    ///this are query parameters that would
    /// be attached to the url
    /// [e.g]=>{"a":"yes"}
    /// she.com/getPeople?a=yes
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> requestHeaders = const {},
    Object body = const {},
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch(
        uri,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: {..._getAuthHeader, ...requestHeaders},
        ),
      );
      return response.data as T;
    } on PlatformException {
      rethrow;
    }
  }

// ======================================================
//======================== delete ==========================
//=======================================================
  ///get request
  Future<T?> delete<T>(
    /// the api route path without the base url
    ///
    String uri, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> requestHeaders = const {},
    // Options options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: Options(
          headers: {..._getAuthHeader, ...requestHeaders},
        ),
      );

      return response.data as T;
    } on PlatformException {
      rethrow;
    }
  }

// ======================================================
//====================== Form data ======================
//=======================================================
  ///Form Data

  Future<dynamic> sendFormData(
    FormDataType requestType, {
    /// route path without baseurl
    required String uri,

    ///this are query parameters that would
    /// be attached to the url
    /// [e.g]=>{"a":"yes"}
    /// she.com/getPeople?a=yes
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> requestHeaders = const {},

    /// data to be sent
    /// [must not add file]
    Map<String, dynamic> body = const {},

    /// Files to be sent
    /// [Files only]
    ///
    /// for all the images you want to send
    /// the key would act as the parameter sent
    /// to the server

    // Map<String, File> images = const {},
    // Map<String, List<File>>? listImages = const {},

    CancelToken? cancelToken,
    File? image,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      FormData formData = FormData.fromMap(body);

      if (image != null) {
        formData.files.add(MapEntry(
          'businessLogo',
          await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
            // contentType: MediaType('image', 'png'),
          ),
        ));
      }

      Response response;
      if (FormDataType.patch == requestType) {
        response = await _dio.patch(
          uri,
          queryParameters: queryParameters,
          data: formData,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: Options(
            headers: {..._getAuthHeader, ...requestHeaders},
          ),
        );
      } else if (FormDataType.put == requestType) {
        response = await _dio.put(
          uri,
          queryParameters: queryParameters,
          data: formData,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: Options(
            headers: {..._getAuthHeader, ...requestHeaders},
          ),
        );
      } else {
        response = await _dio.post(
          uri,
          queryParameters: queryParameters,
          data: formData,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: Options(
            headers: {..._getAuthHeader, ...requestHeaders},
          ),
        );
      }

      return response.data;
    } on PlatformException {
      rethrow;
    }
  }
}
