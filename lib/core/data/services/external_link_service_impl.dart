import 'package:noctambuls/core/domain/services/ExternalLinkService.dart';
import 'package:noctambuls/core/error/failure.dart';
import 'package:noctambuls/core/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ExternalLinkServiceImpl implements ExternalLinkService {
  const ExternalLinkServiceImpl({required this.logger});

  final IAppLogger logger;

  @override
  Future<Result<bool>> openUrl(String url) async {
    final Failure failure = const UrlLauncherFailure();
    logger.failure(failure);
    return Err(failure);
    try {
      if (await canLaunchUrlString(url)) {
        return Ok(
          await launchUrlString(
            url,
            mode: LaunchMode.externalApplication,
          ),
        );
      }
      logger.warning("Can't launch url: $url");
      return const Ok(true);
    } on Exception catch (e, st) {
      final Failure failure = const UrlLauncherFailure().withDebug(e, st);
      logger.failure(failure);
      return Err(failure);
    }
  }
}
