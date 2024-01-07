import 'package:flutter_advanced_topics/src/core/resource/data_state.dart';
import 'package:flutter_advanced_topics/src/data/sources/remote/doc_doc/auth/sign_in/request/sign_in_request.dart';
import 'package:flutter_advanced_topics/src/domain/entities/auth/sign_in_response.dart';

abstract class AuthRepository {
  Future<DataState<SignIn>> signIn({
    required SignInRequest signInRequest,
  });
}
