import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_advanced_topics/src/core/resource/data_state.dart';
import 'package:flutter_advanced_topics/src/core/utils/network/api_error_handler.dart';
import 'package:flutter_advanced_topics/src/core/utils/network/api_result.dart';
import 'package:flutter_advanced_topics/src/data/sources/remote/doc_doc/auth/auth_api_service.dart';
import 'package:flutter_advanced_topics/src/data/sources/remote/doc_doc/auth/sign_in/entity/remote_sign_in.dart';
import 'package:flutter_advanced_topics/src/data/sources/remote/doc_doc/auth/sign_in/request/sign_in_request.dart';
import 'package:flutter_advanced_topics/src/domain/entities/auth/sign_in_response.dart';
import 'package:flutter_advanced_topics/src/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthApiService _authApiService;

  AuthRepositoryImplementation(this._authApiService);

  @override
  Future<ApiResult<SignIn>> signIn({
    required SignInRequest signInRequest,
  }) async {
    try {
      final httpResponse = await _authApiService.signIn(signInRequest);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.status ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return ApiResult.success(DataSuccess(
            data: (httpResponse.data.result?.mapToDomain()),
            message: httpResponse.data.responseMessage ?? "",
          ));
        }
      }
      return ApiResult.failure(
        DataFailed(
          message: httpResponse.data.responseMessage ?? "",
          code: httpResponse.data.statusCode,
        ),
      );
    } on DioException catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel,
      );
    }
  }
}
