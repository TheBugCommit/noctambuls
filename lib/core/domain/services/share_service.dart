import 'package:noctambuls/core/domain/error/result.dart';

abstract class ShareService {
  Future<Result<Unit>> shareText({required String text, String? subject});

  Future<Result<Unit>> shareUri({required Uri uri});
}
