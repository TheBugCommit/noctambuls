import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_auth_request_model.freezed.dart';
part 'google_auth_request_model.g.dart';

@freezed
abstract class GoogleAuthRequestModel with _$GoogleAuthRequestModel {
  const factory GoogleAuthRequestModel({
    @JsonKey(name: 'id_token') required String idToken,
  }) = _GoogleAuthRequestModel;

  factory GoogleAuthRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleAuthRequestModelFromJson(json);
}
