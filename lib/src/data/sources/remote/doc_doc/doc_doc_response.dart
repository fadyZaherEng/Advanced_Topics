import 'package:json_annotation/json_annotation.dart';

part 'doc_doc_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class DocDocResponse<T> {
  @JsonKey(name: 'code')
  int? statusCode;
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'massage')
  String? responseMessage;
  @JsonKey(name: 'data')
  T? result;

  DocDocResponse({
    this.statusCode,
    this.status,
    this.responseMessage,
    this.result,
  });

  factory DocDocResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$DocDocResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Function(dynamic value) value) =>
      _$DocDocResponseToJson(this, (T) {
        return T;
      });
}
