import 'package:flutter_test/flutter_test.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';
import 'package:noctambuls/features/profile/domain/failures/profile_failures.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_state.dart';

void main() {
  final tCreatedAt = DateTime.utc(2024, 1, 15, 10);

  final tProfile = UserProfile(
    id: 'u1',
    name: 'Anna',
    phone: '600000001',
    createdAt: DateTime.utc(2024, 1, 15, 10),
    ornithologistCode: 'ORN-42',
  );

  group('UserProfile equality', () {
    test('mateixos camps → iguals', () {
      final a = UserProfile(
        id: 'u1',
        name: 'Anna',
        phone: '600000001',
        createdAt: DateTime.utc(2024, 1, 15, 10),
        ornithologistCode: 'ORN-42',
      );
      final b = UserProfile(
        id: 'u1',
        name: 'Anna',
        phone: '600000001',
        createdAt: DateTime.utc(2024, 1, 15, 10),
        ornithologistCode: 'ORN-42',
      );

      expect(a, equals(b));
    });

    test('ornithologistCode nul vs no-nul → desiguals', () {
      final withCode = UserProfile(
        id: 'u1',
        name: 'Anna',
        phone: '600000001',
        createdAt: tCreatedAt,
        ornithologistCode: 'ORN-42',
      );
      final withoutCode = UserProfile(
        id: 'u1',
        name: 'Anna',
        phone: '600000001',
        createdAt: tCreatedAt,
      );

      expect(withCode, isNot(equals(withoutCode)));
    });

    test('id diferent → desiguals', () {
      final a = UserProfile(
        id: 'u1',
        name: 'Anna',
        phone: '600000001',
        createdAt: tCreatedAt,
      );
      final b = UserProfile(
        id: 'u2',
        name: 'Anna',
        phone: '600000001',
        createdAt: tCreatedAt,
      );

      expect(a, isNot(equals(b)));
    });
  });

  group('ProfileState.currentProfile getter', () {
    test('ProfileLoaded → retorna el perfil', () {
      final state = ProfileLoaded(profile: tProfile);
      expect(state.currentProfile, tProfile);
    });

    test('ProfileUpdating → retorna el perfil', () {
      final state = ProfileUpdating(profile: tProfile);
      expect(state.currentProfile, tProfile);
    });

    test('ProfileUpdateSuccess → retorna el perfil', () {
      final state = ProfileUpdateSuccess(profile: tProfile);
      expect(state.currentProfile, tProfile);
    });

    test('ProfileUpdateError → retorna el perfil', () {
      final state = ProfileUpdateError(
        failure: const ProfileNetworkFailure(),
        profile: tProfile,
      );
      expect(state.currentProfile, tProfile);
    });

    test('ProfileInitial → retorna null', () {
      expect(const ProfileInitial().currentProfile, isNull);
    });

    test('ProfileLoading → retorna null', () {
      expect(const ProfileLoading().currentProfile, isNull);
    });

    test('ProfileError → retorna null', () {
      expect(
        const ProfileError(failure: ProfileNetworkFailure()).currentProfile,
        isNull,
      );
    });
  });
}
