// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RefreshTokenResponseModel _$RefreshTokenResponseModelFromJson(
  Map<String, dynamic> json,
) => _RefreshTokenResponseModel(
  accessToken: json['token'] as String,
  refreshToken: json['refresh_token'] as String,
);

Map<String, dynamic> _$RefreshTokenResponseModelToJson(
  _RefreshTokenResponseModel instance,
) => <String, dynamic>{
  'token': instance.accessToken,
  'refresh_token': instance.refreshToken,
};
