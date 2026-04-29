import 'package:noctambuls/core/domain/services/external_link_service.dart';
import 'package:noctambuls/core/error/result.dart';

class OpenLinkUseCase {
  const OpenLinkUseCase(this.service);

  final ExternalLinkService service;

  Future<Result<Unit>> call(String url) => service.openUrl(url);
}
