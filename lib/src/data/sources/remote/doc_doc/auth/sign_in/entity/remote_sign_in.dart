import 'package:flutter_advanced_topics/src/domain/entities/auth/sign_in_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_sign_in.g.dart';

@JsonSerializable()
class RemoteSignIn {
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'username')
  final String? username;

  const RemoteSignIn({
    this.token,
    this.username,
  });

  factory RemoteSignIn.fromJson(Map<String, dynamic> json) =>
      _$RemoteSignInFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSignInToJson(this);
}

extension RemoteSignInX on RemoteSignIn? {
  SignIn mapToDomain() {
    return SignIn(
      token: this?.token ?? "",
      username: this?.username ?? "",
    );
  }
}
