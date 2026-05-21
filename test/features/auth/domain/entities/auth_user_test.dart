import 'package:flutter_test/flutter_test.dart';
import 'package:noctambuls/features/auth/domain/entities/auth_user.dart';

void main() {
  group('AuthUser.isTokenExpired', () {
    test('hauria de retornar false si tokenExpiry és en el futur', () {
      final user = AuthUser(
        id: 'user-1',
        email: 'test@noctambuls.cat',
        tokenExpiry: DateTime(2099),
      );

      expect(user.isTokenExpired, isFalse);
    });

    test('hauria de retornar true si tokenExpiry és en el passat', () {
      final user = AuthUser(
        id: 'user-1',
        email: 'test@noctambuls.cat',
        tokenExpiry: DateTime(2020),
      );

      expect(user.isTokenExpired, isTrue);
    });
  });
}
