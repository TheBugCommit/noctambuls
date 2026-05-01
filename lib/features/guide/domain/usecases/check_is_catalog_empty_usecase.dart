import 'package:noctambuls/features/guide/domain/repositories/birds_repository.dart';

class CheckIsCatalogEmptyUseCase {
  const CheckIsCatalogEmptyUseCase(this._repository);

  final BirdsRepository _repository;

  Future<bool> call() async {
    final result = await _repository.getLocalVersion();

    return result.when(
      success: (version) => version == null,
      failure: (_) => true,
    );
  }
}
