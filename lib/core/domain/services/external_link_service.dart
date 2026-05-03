import 'package:noctambuls/core/domain/error/result.dart';

abstract class ExternalLinkService {
  Future<Result<Unit>> openUrl(String url);
}
