import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';

abstract class CensusRepository {
  Stream<List<Census>> watchAll();

  Stream<Census?> watchJoinedCensus();

  Future<Result<Census?>> getById(String id);

  Future<Result<Census?>> getJoinedCensus();

  Future<Result<Unit>> save(Census census);

  Future<Result<Unit>> fetchAndSync();
}
