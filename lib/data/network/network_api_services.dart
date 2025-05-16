// ignore_for_file: file_names
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:roamsavvy/data/exception.dart';
import 'package:roamsavvy/data/network/base_api_services.dart';

class NetworkApiServicce extends BaseApiServices {
  NetworkApiServicce._privateConstructor();
  static final NetworkApiServicce _instance =
      NetworkApiServicce._privateConstructor();
  factory NetworkApiServicce() {
    return _instance;
  }

  final Dio _dio = Dio();
  CancelToken? _cancelToken;

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;

    // Cancel any ongoing API call
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel("Previous API call canceled.");
    }
    _cancelToken = CancelToken();

    try {
      final response = await _dio.get(
        url,
        cancelToken: _cancelToken,
        options: Options(
          sendTimeout: 10000.ms, // 10 seconds timeout
          receiveTimeout: 10000.ms,
        ),
      );
      responseJson = returnresponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw FetchDataExceptions('Request was canceled.');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw FetchDataExceptions('Connection timed out.');
      } else if (e.error is SocketException) {
        throw FetchDataExceptions('No internet connection.');
      } else {
        throw FetchDataExceptions('Unexpected error: ${e.message}');
      }
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    // Cancel any ongoing API call
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel("Previous API call canceled.");
    }
    _cancelToken = CancelToken();

    try {
      final response = await _dio.post(
        url,
        data: data,
        cancelToken: _cancelToken,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          sendTimeout: 10000.ms, // 10 seconds timeout
          receiveTimeout: 10000.ms,
        ),
      );
      responseJson = returnresponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw FetchDataExceptions('Request was canceled.');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw FetchDataExceptions('Connection timed out.');
      } else if (e.error is SocketException) {
        throw FetchDataExceptions('No internet connection.');
      } else {
        throw FetchDataExceptions('Unexpected error: ${e.message}');
      }
    }
    return responseJson;
  }

  static dynamic returnresponse(Response response) {
    try {
      if (response.data == null) {
        throw FetchDataExceptions('Empty response from server.');
      }

      dynamic responseJson = response.data;

      switch (response.statusCode) {
        case 200:
        case 201:
          return responseJson;

        case 400:
          final errorMessage =
              responseJson is Map && responseJson.containsKey('message')
                  ? responseJson['message']
                  : 'Invalid request. Please check your details.';
          throw BadrequestException(errorMessage);
        case 401:
        case 403:
          final unauthorizedMessage =
              responseJson is Map && responseJson.containsKey('message')
                  ? responseJson['message']
                  : 'Unauthorized access. Please log in again.';
          throw UnauthorizedExceptions(unauthorizedMessage);

        case 404:
          final notFoundMessage =
              responseJson is Map && responseJson.containsKey('message')
                  ? responseJson['message']
                  : 'Requested resource not found.';
          throw NotFoundException(notFoundMessage);

        case 500:
        case 502:
        case 503:
          throw FetchDataExceptions('Server error. Please try again later.');

        default:
          throw FetchDataExceptions('Unexpected error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in returnresponse: $e');
      throw FetchDataExceptions('Error parsing response: $e');
    }
  }
}
