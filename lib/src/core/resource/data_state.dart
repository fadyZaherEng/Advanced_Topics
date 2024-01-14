import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;
  String? message;
  int? code;

  DataState({this.data, this.error, this.message, this.code});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({T? data, String? message}) : super(data: data, message: message);
}

class DataFailed<T> extends DataState<T> {
  DataFailed({DioException? error, String? message, int? code})
      : super(
          error: error,
          message: message,
          code: code,
        );
}
