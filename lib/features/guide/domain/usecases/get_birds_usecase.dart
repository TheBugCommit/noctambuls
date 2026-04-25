import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/domain/repositories/birds_repository.dart';

class GetBirdsUseCase {
  const GetBirdsUseCase(this.repository);

  final BirdsRepository repository;

  Future<Result<List<Bird>>> call(String languageCode) =>
      repository.getBirds(languageCode);
}
