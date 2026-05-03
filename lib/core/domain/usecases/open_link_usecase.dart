import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/external_link_service.dart';

class OpenLinkUseCase {
  const OpenLinkUseCase(this.service);

  final ExternalLinkService service;

  Future<Result<Unit>> call(String url) => service.openUrl(url);
}
