import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/share_service.dart';

class ShareUriUseCase {
  const ShareUriUseCase({required this.shareService});

  final ShareService shareService;

  Future<Result<Unit>> call({required Uri uri}) async {
    return shareService.shareUri(uri: uri);
  }
}
