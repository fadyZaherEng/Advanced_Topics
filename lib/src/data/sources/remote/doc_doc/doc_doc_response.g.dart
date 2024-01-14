// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc_doc_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocDocResponse<T> _$DocDocResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    DocDocResponse<T>(
      statusCode: json['code'] as int?,
      status: json['status'] as bool?,
      responseMessage: json['massage'] as String?,
      result: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$DocDocResponseToJson<T>(
  DocDocResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': instance.statusCode,
      'status': instance.status,
      'massage': instance.responseMessage,
      'data': _$nullableGenericToJson(instance.result, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
