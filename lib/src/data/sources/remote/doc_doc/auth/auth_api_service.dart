import 'package:dio/dio.dart';
import 'package:flutter_advanced_topics/src/data/sources/remote/api_key.dart';
import 'package:flutter_advanced_topics/src/data/sources/remote/doc_doc/auth/sign_in/entity/remote_sign_in.dart';
import 'package:flutter_advanced_topics/src/data/sources/remote/doc_doc/auth/sign_in/request/sign_in_request.dart';
import 'package:flutter_advanced_topics/src/data/sources/remote/doc_doc/doc_doc_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: APIKeys.baseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST(APIKeys.signIn)
  Future<HttpResponse<DocDocResponse<RemoteSignIn>>> signIn(
    @Body() SignInRequest signInRequest,
  );
}
