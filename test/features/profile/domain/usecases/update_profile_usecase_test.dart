import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';
import 'package:noctambuls/features/profile/domain/failures/profile_failures.dart';
import 'package:noctambuls/features/profile/domain/repositories/profile_repository.dart';
import 'package:noctambuls/features/profile/domain/usecases/update_profile_usecase.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late MockProfileRepository mockRepo;
  late UpdateProfileUseCase usecase;

  const tUserId = 'u1';
  const tParams = UpdateProfileParams(
    userId: tUserId,
    name: 'Anna',
    phone: '600000001',
  );
  final tUpdatedProfile = UserProfile(
    id: 'u1',
    name: 'Anna',
    phone: '600000001',
    createdAt: DateTime.utc(2024, 1, 15, 10),
  );

  setUp(() {
    mockRepo = MockProfileRepository();
    usecase = UpdateProfileUseCase(mockRepo);
  });

  group('UpdateProfileParams equality', () {
    test('mateixos camps → iguals', () {
      const a = UpdateProfileParams(
        userId: 'u1',
        name: 'Anna',
        phone: '600000001',
      );
      const b = UpdateProfileParams(
        userId: 'u1',
        name: 'Anna',
        phone: '600000001',
      );

      expect(a, equals(b));
    });

    test('name diferent → desiguals', () {
      const a = UpdateProfileParams(userId: 'u1', name: 'Anna', phone: '600');
      const b = UpdateProfileParams(userId: 'u1', name: 'Bob', phone: '600');

      expect(a, isNot(equals(b)));
    });
  });

  group('call', () {
    test('delega a repository.updateProfile i retorna Ok(profile)', () async {
      when(() => mockRepo.updateProfile(tUserId, tParams))
          .thenAnswer((_) async => Ok(tUpdatedProfile));

      final result = await usecase(tParams);

      expect(result, isA<Ok<UserProfile>>());
      expect((result as Ok<UserProfile>).value, tUpdatedProfile);
      verify(() => mockRepo.updateProfile(tUserId, tParams)).called(1);
    });

    test('propaga Err(ProfileUpdateFailure)', () async {
      when(() => mockRepo.updateProfile(tUserId, tParams))
          .thenAnswer((_) async => const Err(ProfileUpdateFailure()));

      final result = await usecase(tParams);

      expect(result, isA<Err<UserProfile>>());
      expect((result as Err<UserProfile>).failure, isA<ProfileUpdateFailure>());
    });

    test('crida updateProfile amb userId i params exactes', () async {
      when(() => mockRepo.updateProfile(tUserId, tParams))
          .thenAnswer((_) async => Ok(tUpdatedProfile));

      await usecase(tParams);

      verify(() => mockRepo.updateProfile(tUserId, tParams)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
