// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignUpRequestModel _$SignUpRequestModelFromJson(Map<String, dynamic> json) =>
    _SignUpRequestModel(
      idToken: json['id_token'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$SignUpRequestModelToJson(_SignUpRequestModel instance) =>
    <String, dynamic>{
      'id_token': instance.idToken,
      'name': instance.name,
      'phone': instance.phone,
    };
