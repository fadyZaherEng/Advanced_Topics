import 'package:flutter_advanced_topics/src/core/resource/data_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

@Freezed()
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(DataState data) = Success<T>;
  const factory ApiResult.failure(DataState dataFailed) = Failure<T>;
}
