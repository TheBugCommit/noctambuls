import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';
import 'package:noctambuls/features/profile/domain/failures/profile_failures.dart';
import 'package:noctambuls/features/profile/domain/repositories/profile_repository.dart';
import 'package:noctambuls/features/profile/domain/usecases/get_profile_usecase.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late MockProfileRepository mockRepo;
  late GetProfileUseCase usecase;

  const tUserId = 'u1';
  final tProfile = UserProfile(
    id: 'u1',
    name: 'Anna',
    phone: '600000001',
    createdAt: DateTime.utc(2024, 1, 15, 10),
  );

  setUp(() {
    mockRepo = MockProfileRepository();
    usecase = GetProfileUseCase(mockRepo);
  });

  test('delega a repository.getProfile i retorna Ok(profile)', () async {
    when(() => mockRepo.getProfile(tUserId))
        .thenAnswer((_) async => Ok(tProfile));

    final result = await usecase(tUserId);

    expect(result, isA<Ok<UserProfile>>());
    expect((result as Ok<UserProfile>).value, tProfile);
    verify(() => mockRepo.getProfile(tUserId)).called(1);
  });

  test('delega a repository.getProfile i propaga Err(ProfileNotFoundFailure)',
      () async {
    when(() => mockRepo.getProfile(tUserId))
        .thenAnswer((_) async => const Err(ProfileNotFoundFailure()));

    final result = await usecase(tUserId);

    expect(result, isA<Err<UserProfile>>());
    expect((result as Err<UserProfile>).failure, isA<ProfileNotFoundFailure>());
    verify(() => mockRepo.getProfile(tUserId)).called(1);
  });
}
