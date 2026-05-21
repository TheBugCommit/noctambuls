import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_provider_type.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';
import 'package:noctambuls/features/auth/domain/repositories/auth_repository.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_up_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class FakeSignUpParams extends Fake implements SignUpParams {}

void main() {
  late SignUpUseCase usecase;
  late MockAuthRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeSignUpParams());
  });

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = SignUpUseCase(mockRepository);
  });

  final tAuthUser = AuthUser(
    id: 'user-1',
    email: 'test@noctambuls.cat',
    tokenExpiry: DateTime(2099),
  );

  const tParams = SignUpParams(
    provider: AuthProviderType.google,
    idToken: 'id-token-abc',
    name: 'Oriol',
    phone: '+34600000000',
  );

  group('SignUpUseCase', () {
    test('hauria de delegar a repository.signUp i retornar Ok(AuthUser)', () async {
      when(
        () => mockRepository.signUp(any()),
      ).thenAnswer((_) async => Ok(tAuthUser));

      final result = await usecase(tParams);

      expect(result, isA<Ok<AuthUser>>());
      verify(() => mockRepository.signUp(tParams)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('hauria de propagar Err(SignUpFailure) del repositori', () async {
      when(
        () => mockRepository.signUp(any()),
      ).thenAnswer((_) async => const Err(SignUpFailure()));

      final result = await usecase(tParams);

      expect(result, isA<Err<AuthUser>>());
      expect((result as Err<AuthUser>).failure, isA<SignUpFailure>());
    });
  });
}
