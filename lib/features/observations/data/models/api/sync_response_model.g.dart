// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyncResponseModel _$SyncResponseModelFromJson(Map<String, dynamic> json) =>
    _SyncResponseModel(
      synced: (json['synced'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      failed: (json['failed'] as List<dynamic>)
          .map((e) => SyncFailedDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SyncResponseModelToJson(_SyncResponseModel instance) =>
    <String, dynamic>{'synced': instance.synced, 'failed': instance.failed};

_SyncFailedDto _$SyncFailedDtoFromJson(Map<String, dynamic> json) =>
    _SyncFailedDto(
      sessionId: json['sessionId'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$SyncFailedDtoToJson(_SyncFailedDto instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'reason': instance.reason,
    };
