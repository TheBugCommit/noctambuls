import 'package:flutter_test/flutter_test.dart';
import 'package:noctambuls/features/auth/data/models/auth_user_model.dart';

import '../../helpers/jwt_helper.dart';

void main() {
  const tId = 'user-123';
  const tEmail = 'test@noctambuls.cat';

  group('AuthUserModel.fromJwt', () {
    test('hauria de retornar un model correcte amb JWT vàlid', () {
      final jwt = makeJwt(id: tId, email: tEmail, exp: futureExp);

      final model = AuthUserModel.fromJwt(jwt);

      expect(model.id, tId);
      expect(model.email, tEmail);
      expect(model.toDomain().isTokenExpired, isFalse);
    });

    test('hauria de retornar un model amb tokenExpiry caducat si exp és al passat', () {
      final jwt = makeJwt(id: tId, email: tEmail, exp: pastExp);

      final model = AuthUserModel.fromJwt(jwt);

      expect(model.toDomain().isTokenExpired, isTrue);
    });

    test('hauria de propagar photoUrl si es passa', () {
      final jwt = makeJwt(id: tId, email: tEmail, exp: futureExp);

      final model = AuthUserModel.fromJwt(jwt, photoUrl: 'https://example.com/photo.jpg');

      expect(model.photoUrl, 'https://example.com/photo.jpg');
    });

    test('hauria de llançar FormatException si el JWT és malformat', () {
      expect(
        () => AuthUserModel.fromJwt('not-a-valid-jwt'),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
