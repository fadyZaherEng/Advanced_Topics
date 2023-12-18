import 'package:flutter_advanced_topics/src/core/utils/network/api_result.dart';
import 'package:flutter_advanced_topics/src/data/sources/remote/doc_doc/auth/sign_in/request/sign_in_request.dart';
import 'package:flutter_advanced_topics/src/domain/entities/auth/sign_in_response.dart';
import 'package:flutter_advanced_topics/src/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  Future<ApiResult<SignIn>> call({
    required SignInRequest signInRequest,
  }) async {
    return await _authRepository.signIn(
      signInRequest: signInRequest,
    );
  }
}
