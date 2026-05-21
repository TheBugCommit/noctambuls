import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/auth/domain/failures/auth_failures.dart';
import 'package:noctambuls/features/auth/domain/repositories/auth_repository.dart';
import 'package:noctambuls/features/auth/domain/usecases/delete_account_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late DeleteAccountUseCase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = DeleteAccountUseCase(mockRepository);
  });

  group('DeleteAccountUseCase', () {
    test('hauria de delegar a repository.deleteAccount i retornar Ok(Unit)', () async {
      when(
        () => mockRepository.deleteAccount(),
      ).thenAnswer((_) async => const Ok(Unit.instance));

      final result = await usecase();

      expect(result, isA<Ok<Unit>>());
      verify(() => mockRepository.deleteAccount()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('hauria de propagar Err(DeleteAccountFailure) del repositori', () async {
      when(
        () => mockRepository.deleteAccount(),
      ).thenAnswer((_) async => const Err(DeleteAccountFailure()));

      final result = await usecase();

      expect(result, isA<Err<Unit>>());
      expect((result as Err<Unit>).failure, isA<DeleteAccountFailure>());
    });
  });
}
