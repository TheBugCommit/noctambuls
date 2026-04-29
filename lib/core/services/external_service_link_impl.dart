import 'package:noctambuls/core/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/core/services/external_service_link.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ExternalLinkServiceImpl implements ExternalLinkService {
  const ExternalLinkServiceImpl({required this.logger});

  final IAppLogger logger;

  @override
  Future<bool> openUrl(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        return await launchUrlString(
          url,
          mode: LaunchMode.externalApplication,
        );
      }
      logger.warning("Can't launch url: $url");
      return false;
    } on Exception catch (e, st) {
      logger.failure(const UrlLauncherFailure().withDebug(e, st));
      return false;
    }
  }
}
