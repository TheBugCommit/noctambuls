import 'package:noctambuls/core/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/core/services/external_service_link.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ExternalLinkServiceImpl implements ExternalLinkService {
  @override
  Future<bool> openUrl(String url) async {
    AppLogger.failure(const UnknownFailure());

    try {
      if (await canLaunchUrlString(url)) {
        return await launchUrlString(
          url,
          mode: LaunchMode.externalApplication,
        );
      }
      AppLogger.warning(
        'canLaunchUrlString ha retornat false per la URL: $url',
      );
      return false;
    } on Exception catch (e, st) {
      AppLogger.failure(const UnknownFailure().withDebug(e, st));
      return false;
    }
  }
}
