import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';
import 'package:noctambuls/features/auth/domain/repositories/auth_repository.dart';
import 'package:noctambuls/features/auth/domain/usecases/sign_out_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignOutUseCase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = SignOutUseCase(mockRepository);
  });

  group('SignOutUseCase', () {
    test('hauria de delegar a repository.signOut i retornar Ok(Unit)', () async {
      when(
        () => mockRepository.signOut(),
      ).thenAnswer((_) async => const Ok(Unit.instance));

      final result = await usecase();

      expect(result, isA<Ok<Unit>>());
      verify(() => mockRepository.signOut()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('hauria de propagar Err(TokenStorageFailure) del repositori', () async {
      when(
        () => mockRepository.signOut(),
      ).thenAnswer((_) async => const Err(TokenStorageFailure()));

      final result = await usecase();

      expect(result, isA<Err<Unit>>());
      expect((result as Err<Unit>).failure, isA<TokenStorageFailure>());
    });
  });
}
