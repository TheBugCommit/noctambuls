import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_response_model.freezed.dart';
part 'sync_response_model.g.dart';

@freezed
abstract class SyncResponseModel with _$SyncResponseModel {
  const factory SyncResponseModel({
    required List<String> synced,
    required List<SyncFailedDto> failed,
  }) = _SyncResponseModel;

  factory SyncResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SyncResponseModelFromJson(json);
}

@freezed
abstract class SyncFailedDto with _$SyncFailedDto {
  const factory SyncFailedDto({
    required String sessionId,
    required String reason,
  }) = _SyncFailedDto;

  factory SyncFailedDto.fromJson(Map<String, dynamic> json) =>
      _$SyncFailedDtoFromJson(json);
}
