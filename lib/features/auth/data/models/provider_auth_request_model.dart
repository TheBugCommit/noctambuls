import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider_auth_request_model.freezed.dart';
part 'provider_auth_request_model.g.dart';

@freezed
abstract class ProviderAuthRequestModel with _$ProviderAuthRequestModel {
  const factory ProviderAuthRequestModel({
    @JsonKey(name: 'id_token') required String idToken,
  }) = _ProviderAuthRequestModel;

  factory ProviderAuthRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ProviderAuthRequestModelFromJson(json);
}
