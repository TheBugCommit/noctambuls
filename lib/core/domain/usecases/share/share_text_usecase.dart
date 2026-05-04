import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/share_service.dart';

class ShareTextUseCase {
  const ShareTextUseCase({required this.shareService});

  final ShareService shareService;

  Future<Result<Unit>> call({required String text, String? subject}) async {
    return shareService.shareText(text: text, subject: subject);
  }
}
