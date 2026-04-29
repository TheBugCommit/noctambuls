import 'package:noctambuls/core/error/result.dart';

abstract class ExternalLinkService {
  Future<Result<bool>> openUrl(String url);
}
