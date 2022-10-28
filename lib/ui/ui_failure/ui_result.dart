import 'package:task/core/network/utils/base_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_result.freezed.dart';

@freezed
class UiResult<T> with _$UiResult {
  const factory UiResult.success(T data) = UiSuccess<T>;

  const factory UiResult.failure(ErrorType type, [String? code]) = UiFailure<T>;
}
