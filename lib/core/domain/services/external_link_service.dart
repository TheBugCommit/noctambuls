import 'package:noctambuls/core/error/result.dart';

abstract class ExternalLinkService {
  Future<Result<Unit>> openUrl(String url);
}
