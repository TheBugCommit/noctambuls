import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';
import 'package:noctambuls/features/auth/domain/repositories/auth_repository.dart';
import 'package:noctambuls/features/auth/domain/usecases/get_stored_auth_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late GetStoredAuthUseCase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = GetStoredAuthUseCase(mockRepository);
  });

  final tAuthUser = AuthUser(
    id: 'user-1',
    email: 'test@noctambuls.cat',
    tokenExpiry: DateTime(2099),
  );

  group('GetStoredAuthUseCase', () {
    test('hauria de delegar a repository.getStoredAuth i retornar Ok(AuthUser)', () async {
      when(
        () => mockRepository.getStoredAuth(),
      ).thenAnswer((_) async => Ok(tAuthUser));

      final result = await usecase();

      expect(result, isA<Ok<AuthUser>>());
      verify(() => mockRepository.getStoredAuth()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('hauria de propagar Err(InvalidTokenFailure) del repositori', () async {
      when(
        () => mockRepository.getStoredAuth(),
      ).thenAnswer((_) async => const Err(InvalidTokenFailure()));

      final result = await usecase();

      expect(result, isA<Err<AuthUser>>());
      expect((result as Err<AuthUser>).failure, isA<InvalidTokenFailure>());
    });
  });
}
