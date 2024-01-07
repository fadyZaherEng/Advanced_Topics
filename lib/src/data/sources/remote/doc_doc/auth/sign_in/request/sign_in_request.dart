import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_request.g.dart';

@JsonSerializable()
class SignInRequest {
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;

  SignInRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}
