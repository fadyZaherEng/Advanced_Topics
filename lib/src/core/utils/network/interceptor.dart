import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CustomInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint(
        "REQUEST [${' '}${options.method}${' '}] ${' '} URL: ${options.baseUrl + options.path} ${jsonEncode(options.data)}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    debugPrint(
        "RESPONSE [${' '}${response.statusCode}${' '}]${'\n'}${jsonEncode(response.data)}");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    debugPrint(
        "ERROR [${' '}${err.response?.statusCode}${' '}]${'\n'} error message =>"
        " ${err.response.toString()} ${'\n'} error header => ");
    return super.onError(err, handler);
  }
}
