import 'package:noctambuls/core/domain/services/ExternalLinkService.dart';
import 'package:noctambuls/core/error/result.dart';

class OpenLinkUseCase {
  const OpenLinkUseCase(this.service);

  final ExternalLinkService service;

  Future<Result<bool>> call(String url) => service.openUrl(url);
}
