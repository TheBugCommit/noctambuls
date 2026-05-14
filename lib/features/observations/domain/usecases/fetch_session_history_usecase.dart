import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/domain/entities/pagination_meta.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class FetchSessionHistoryUseCase {
  FetchSessionHistoryUseCase(this._repository);

  final SessionRepository _repository;

  Future<Result<PaginationMeta>> call({int limit = 20, bool refresh = false}) =>
      _repository.fetchAndStoreHistory(limit: limit, refresh: refresh);
}
