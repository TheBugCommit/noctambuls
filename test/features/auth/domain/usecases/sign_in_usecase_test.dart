import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';
import 'package:noctambuls/features/auth/domain/repositories/auth_repository.dart';
import 'package:noctambuls/features/auth/domain/usecases/auth_credentials.dart'
    show GoogleAuthCredentials;
import 'package:noctambuls/features/auth/domain/usecases/sign_in_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignInUseCase usecase;
  late MockAuthRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(const GoogleAuthCredentials());
  });

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = SignInUseCase(mockRepository);
  });

  final tAuthUser = AuthUser(
    id: 'user-1',
    email: 'test@noctambuls.cat',
    tokenExpiry: DateTime(2099),
  );

  group('SignInUseCase', () {
    test('hauria de delegar a repository.signIn i retornar Ok(AuthUser)', () async {
      when(
        () => mockRepository.signIn(any()),
      ).thenAnswer((_) async => Ok(tAuthUser));

      final result = await usecase(const GoogleAuthCredentials());

      expect(result, isA<Ok<AuthUser>>());
      verify(() => mockRepository.signIn(const GoogleAuthCredentials())).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('hauria de propagar Err(BackendAuthFailure) del repositori', () async {
      when(
        () => mockRepository.signIn(any()),
      ).thenAnswer((_) async => const Err(BackendAuthFailure()));

      final result = await usecase(const GoogleAuthCredentials());

      expect(result, isA<Err<AuthUser>>());
      expect((result as Err<AuthUser>).failure, isA<BackendAuthFailure>());
    });
  });
}
