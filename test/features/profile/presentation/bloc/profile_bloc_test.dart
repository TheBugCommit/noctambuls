import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';
import 'package:noctambuls/features/profile/domain/failures/profile_failures.dart';
import 'package:noctambuls/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:noctambuls/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_event.dart';
import 'package:noctambuls/features/profile/presentation/bloc/profile_state.dart';

class MockGetProfileUseCase extends Mock implements GetProfileUseCase {}

class MockUpdateProfileUseCase extends Mock implements UpdateProfileUseCase {}

class FakeUpdateProfileParams extends Fake implements UpdateProfileParams {}

void main() {
  late MockGetProfileUseCase mockGet;
  late MockUpdateProfileUseCase mockUpdate;

  const tUserId = 'u1';
  final tProfile = UserProfile(
    id: 'u1',
    name: 'Anna',
    phone: '600000001',
    createdAt: DateTime.utc(2024, 1, 15, 10),
  );
  final tUpdatedProfile = UserProfile(
    id: 'u1',
    name: 'Bob',
    phone: '700000002',
    createdAt: DateTime.utc(2024, 1, 15, 10),
  );
  const tFailure = ProfileNetworkFailure();

  setUpAll(() {
    registerFallbackValue(FakeUpdateProfileParams());
  });

  setUp(() {
    mockGet = MockGetProfileUseCase();
    mockUpdate = MockUpdateProfileUseCase();
  });

  ProfileBloc buildBloc() => ProfileBloc(
        getProfileUseCase: mockGet,
        updateProfileUseCase: mockUpdate,
      );

  group('ProfileLoadRequested', () {
    blocTest<ProfileBloc, ProfileState>(
      'èxit → [ProfileLoading, ProfileLoaded]',
      build: buildBloc,
      setUp: () => when(() => mockGet(tUserId))
          .thenAnswer((_) async => Ok(tProfile)),
      act: (b) => b.add(const ProfileLoadRequested(userId: tUserId)),
      expect: () => [
        const ProfileLoading(),
        ProfileLoaded(profile: tProfile),
      ],
      verify: (_) => verify(() => mockGet(tUserId)).called(1),
    );

    blocTest<ProfileBloc, ProfileState>(
      'error → [ProfileLoading, ProfileError]',
      build: buildBloc,
      setUp: () => when(() => mockGet(tUserId))
          .thenAnswer((_) async => const Err(tFailure)),
      act: (b) => b.add(const ProfileLoadRequested(userId: tUserId)),
      expect: () => [
        const ProfileLoading(),
        const ProfileError(failure: tFailure),
      ],
    );
  });

  group('ProfileUpdateRequested', () {
    blocTest<ProfileBloc, ProfileState>(
      'estat sense perfil actual (ProfileInitial) → cap emissió',
      build: buildBloc,
      seed: () => const ProfileInitial(),
      act: (b) => b.add(
        const ProfileUpdateRequested(
          userId: tUserId,
          name: 'Bob',
          phone: '700000002',
        ),
      ),
      expect: () => <ProfileState>[],
      verify: (_) => verifyNever(() => mockUpdate(any())),
    );

    blocTest<ProfileBloc, ProfileState>(
      'estat amb perfil, èxit → [ProfileUpdating, ProfileUpdateSuccess]',
      build: buildBloc,
      seed: () => ProfileLoaded(profile: tProfile),
      setUp: () => when(() => mockUpdate(any()))
          .thenAnswer((_) async => Ok(tUpdatedProfile)),
      act: (b) => b.add(
        const ProfileUpdateRequested(
          userId: tUserId,
          name: 'Bob',
          phone: '700000002',
        ),
      ),
      expect: () => [
        ProfileUpdating(profile: tProfile),
        ProfileUpdateSuccess(profile: tUpdatedProfile),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'estat amb perfil, error → [ProfileUpdating, ProfileUpdateError] preservant perfil anterior',
      build: buildBloc,
      seed: () => ProfileLoaded(profile: tProfile),
      setUp: () => when(() => mockUpdate(any()))
          .thenAnswer((_) async => const Err(tFailure)),
      act: (b) => b.add(
        const ProfileUpdateRequested(
          userId: tUserId,
          name: 'Bob',
          phone: '700000002',
        ),
      ),
      expect: () => [
        ProfileUpdating(profile: tProfile),
        ProfileUpdateError(failure: tFailure, profile: tProfile),
      ],
      verify: (_) {
        final captured =
            verify(() => mockUpdate(captureAny())).captured.single
                as UpdateProfileParams;
        expect(captured.userId, tUserId);
        expect(captured.name, 'Bob');
        expect(captured.phone, '700000002');
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'ProfileUpdateError preserva el perfil anterior (no el perfil actualitzat)',
      build: buildBloc,
      seed: () => ProfileLoaded(profile: tProfile),
      setUp: () => when(() => mockUpdate(any()))
          .thenAnswer((_) async => const Err(tFailure)),
      act: (b) => b.add(
        const ProfileUpdateRequested(
          userId: tUserId,
          name: 'Bob',
          phone: '700000002',
        ),
      ),
      verify: (b) {
        final errorState = b.state as ProfileUpdateError;
        expect(errorState.profile, tProfile);
        expect(errorState.failure, tFailure);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'ProfileUpdating com a seed → currentProfile no nul → pot actualitzar',
      build: buildBloc,
      seed: () => ProfileUpdating(profile: tProfile),
      setUp: () => when(() => mockUpdate(any()))
          .thenAnswer((_) async => Ok(tUpdatedProfile)),
      act: (b) => b.add(
        const ProfileUpdateRequested(
          userId: tUserId,
          name: 'Bob',
          phone: '700000002',
        ),
      ),
      // Seed is already ProfileUpdating(tProfile); bloc deduplicates equal states,
      // so only the final transition to ProfileUpdateSuccess is emitted.
      expect: () => [
        ProfileUpdateSuccess(profile: tUpdatedProfile),
      ],
    );
  });
}
