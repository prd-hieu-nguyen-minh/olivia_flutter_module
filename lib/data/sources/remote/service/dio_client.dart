import 'dart:io';

import 'package:dio/dio.dart';
import 'package:olivia_flutter_module/main.dart';

const _kDefaultConnectTimeout = Duration.millisecondsPerMinute;
const _kDefaultReceiveTimeout = Duration.millisecondsPerMinute;

class DioService {
  final Dio _dio;
  final List<Interceptor> interceptors;

  DioService(
    Dio dio, {
    this.interceptors = const [],
  }) : _dio = Dio() {
    _dio
      ..options.connectTimeout =
          const Duration(milliseconds: _kDefaultConnectTimeout)
      ..options.receiveTimeout =
          const Duration(milliseconds: _kDefaultReceiveTimeout)
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};
    if (interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var apiUrl = await SampleCallNativeFlutter.apiUrl;
      if (apiUrl == null) {
        throw Exception("Api url not found");
      }
      final response = await _dio.get(
        "$apiUrl$uri",
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var apiUrl = await SampleCallNativeFlutter.apiUrl;
      if (apiUrl == null) {
        throw Exception("Api url not found");
      }
      final response = await _dio.post(
        "$apiUrl$uri",
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
