import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_response_model.freezed.dart';
part 'refresh_token_response_model.g.dart';

@freezed
abstract class RefreshTokenResponseModel with _$RefreshTokenResponseModel {
  const factory RefreshTokenResponseModel({
    @JsonKey(name: 'token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _RefreshTokenResponseModel;

  factory RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseModelFromJson(json);
}
