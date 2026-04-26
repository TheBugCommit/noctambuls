import 'dart:convert';

import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  const AuthUserModel({
    required super.id,
    required super.email,
    required super.tokenExpiry,
  });

  /// Decodes the JWT payload and builds an [AuthUserModel].
  /// Throws [FormatException] if the JWT is malformed.
  factory AuthUserModel.fromJwt(String jwt) {
    final parts = jwt.split('.');
    if (parts.length != 3) {
      throw const FormatException('Invalid JWT format');
    }

    final normalized = base64Url.normalize(parts[1]);
    final decoded = utf8.decode(base64Url.decode(normalized));
    final claims = jsonDecode(decoded) as Map<String, dynamic>;

    final exp = claims['exp'] as int? ?? 0;

    return AuthUserModel(
      id: claims['id'] as String? ?? '',
      email: claims['email'] as String? ?? '',
      tokenExpiry: DateTime.fromMillisecondsSinceEpoch(exp * 1000),
    );
  }
}
