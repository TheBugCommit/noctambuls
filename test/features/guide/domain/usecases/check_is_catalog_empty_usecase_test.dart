import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/guide/domain/failures/guide_failures.dart';
import 'package:noctambuls/features/guide/domain/repositories/birds_repository.dart';
import 'package:noctambuls/features/guide/domain/usecases/check_is_catalog_empty_usecase.dart';

class MockBirdsRepository extends Mock implements BirdsRepository {}

void main() {
  late MockBirdsRepository mockRepo;
  late CheckIsCatalogEmptyUseCase usecase;

  setUp(() {
    mockRepo = MockBirdsRepository();
    usecase = CheckIsCatalogEmptyUseCase(mockRepo);
  });

  test('getLocalVersion → Ok(null) → call() retorna true (catàleg buit)', () async {
    when(() => mockRepo.getLocalVersion()).thenAnswer((_) async => const Ok(null));

    expect(await usecase(), isTrue);
  });

  test("getLocalVersion → Ok('v1') → call() retorna false (catàleg no buit)", () async {
    when(() => mockRepo.getLocalVersion()).thenAnswer((_) async => const Ok('v1'));

    expect(await usecase(), isFalse);
  });

  test('getLocalVersion → Err → call() retorna true (tractat com a buit)', () async {
    when(() => mockRepo.getLocalVersion())
        .thenAnswer((_) async => const Err(GuideFetchFailure()));

    expect(await usecase(), isTrue);
  });
}
