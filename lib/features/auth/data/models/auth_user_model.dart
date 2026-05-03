import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';

part 'auth_user_model.freezed.dart';

@freezed
abstract class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel({
    required String id,
    required String email,
    required DateTime tokenExpiry,
    String? photoUrl,
  }) = _AuthUserModel;

  /// Decodes the JWT payload and builds an [AuthUserModel].
  /// Throws [FormatException] if the JWT is malformed.
  factory AuthUserModel.fromJwt(String jwt, {String? photoUrl}) {
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
      email: claims['username'] as String? ?? '',
      tokenExpiry: DateTime.fromMillisecondsSinceEpoch(exp * 1000),
      photoUrl: photoUrl,
    );
  }
}

extension AuthUserModelX on AuthUserModel {
  AuthUser toDomain() => AuthUser(
    id: id,
    email: email,
    tokenExpiry: tokenExpiry,
    photoUrl: photoUrl,
  );
}
