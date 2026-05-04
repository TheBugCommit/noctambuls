import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/services/share_service.dart';
import 'package:share_plus/share_plus.dart';

class ShareServiceImpl implements ShareService {
  @override
  Future<Result<Unit>> shareText({
    required String text,
    String? subject,
  }) async {
    try {
      await Share.share(text, subject: subject);
      return const Ok(Unit.instance);
    } catch (e, st) {
      return Err(const UnknownFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<Unit>> shareUri({required Uri uri}) async {
    try {
      await Share.shareUri(uri);
      return const Ok(Unit.instance);
    } catch (e, st) {
      return Err(const UnknownFailure().withDebug(e, st));
    }
  }
}
