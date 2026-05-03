import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/external_link_service.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ExternalLinkServiceImpl implements ExternalLinkService {
  const ExternalLinkServiceImpl({required this.logger});

  final IAppLogger logger;

  @override
  Future<Result<Unit>> openUrl(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        final launched = await launchUrlString(
          url,
          mode: LaunchMode.externalApplication,
        );

        if (launched) {
          return const Ok(Unit.instance);
        } else {
          final failure = const UrlLauncherFailure().withDebug(
            'Failed to launch URL despite canLaunch being true',
          );
          logger.warning("Can't launch url: $url");
          return Err(failure);
        }
      }

      final failure = const UrlLauncherFailure().withDebug(
        'canLaunchUrlString returned false',
      );
      logger.warning('Cannot launch URL format: $url');
      return Err(failure);
    } on Exception catch (e, st) {
      final Failure failure = const UrlLauncherFailure().withDebug(e, st);
      logger.failure(failure);
      return Err(failure);
    }
  }
}
