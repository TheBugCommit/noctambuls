import 'package:flutter_test/flutter_test.dart';
import 'package:noctambuls/features/profile/data/models/update_profile_request_model.dart';
import 'package:noctambuls/features/profile/data/models/user_profile_model.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';

void main() {
  final tCreatedAt = DateTime.utc(2024, 1, 15, 10);

  final tJson = <String, dynamic>{
    'id': 'u1',
    'name': 'Anna',
    'phone': '600000001',
    'createdAt': '2024-01-15T10:00:00.000Z',
    'ornithologistCode': 'ORN-42',
  };

  final tModel = UserProfileModel(
    id: 'u1',
    name: 'Anna',
    phone: '600000001',
    createdAt: tCreatedAt,
    ornithologistCode: 'ORN-42',
  );

  final tEntity = UserProfile(
    id: 'u1',
    name: 'Anna',
    phone: '600000001',
    createdAt: tCreatedAt,
    ornithologistCode: 'ORN-42',
  );

  group('UserProfileModel.fromJson', () {
    test('JSON complet → tots els camps correctes', () {
      final model = UserProfileModel.fromJson(tJson);

      expect(model.id, 'u1');
      expect(model.name, 'Anna');
      expect(model.phone, '600000001');
      expect(model.ornithologistCode, 'ORN-42');
      expect(model.createdAt, tCreatedAt);
    });

    test('ornithologistCode absent → null', () {
      final json = Map<String, dynamic>.from(tJson)
        ..remove('ornithologistCode');

      final model = UserProfileModel.fromJson(json);

      expect(model.ornithologistCode, isNull);
    });

    test('ornithologistCode explícitament null → null', () {
      final json = Map<String, dynamic>.from(tJson)
        ..['ornithologistCode'] = null;

      final model = UserProfileModel.fromJson(json);

      expect(model.ornithologistCode, isNull);
    });
  });

  group('UserProfileModel.toDomain', () {
    test('converteix correctament a UserProfile', () {
      final profile = tModel.toDomain();

      expect(profile.id, 'u1');
      expect(profile.name, 'Anna');
      expect(profile.phone, '600000001');
      expect(profile.ornithologistCode, 'ORN-42');
      expect(profile.createdAt, tCreatedAt);
    });

    test('ornithologistCode null es preserva al domain', () {
      final modelSenseCode = UserProfileModel(
        id: 'u1',
        name: 'Anna',
        phone: '600000001',
        createdAt: tCreatedAt,
      );

      expect(modelSenseCode.toDomain().ornithologistCode, isNull);
    });
  });

  group('UserProfileModel.fromEntity', () {
    test('round-trip fromEntity → toDomain == entity original', () {
      final roundTripped = UserProfileModel.fromEntity(tEntity).toDomain();

      expect(roundTripped, equals(tEntity));
    });

    test('round-trip sense ornithologistCode', () {
      final entitySenseCode = UserProfile(
        id: 'u1',
        name: 'Anna',
        phone: '600000001',
        createdAt: tCreatedAt,
      );

      final roundTripped =
          UserProfileModel.fromEntity(entitySenseCode).toDomain();

      expect(roundTripped, equals(entitySenseCode));
    });
  });

  group('UpdateProfileRequestModel.toJson', () {
    test('toJson → {name, phone}', () {
      const model = UpdateProfileRequestModel(name: 'Anna', phone: '600000001');

      final json = model.toJson();

      expect(json, {'name': 'Anna', 'phone': '600000001'});
    });

    test('toJson no inclou camps extra', () {
      const model = UpdateProfileRequestModel(name: 'Bob', phone: '700');

      final json = model.toJson();

      expect(json.keys, containsAll(['name', 'phone']));
      expect(json.length, 2);
    });
  });
}
