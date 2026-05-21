import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/features/auth/data/datasources/token_local_datasource.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late TokenLocalDataSourceImpl datasource;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    datasource = TokenLocalDataSourceImpl(storage: mockStorage);
  });

  group('saveTokenPair', () {
    test('escriu accessToken i refreshToken a storage', () async {
      when(
        () => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')),
      ).thenAnswer((_) async {});

      await datasource.saveTokenPair('access-abc', 'refresh-xyz');

      verify(
        () => mockStorage.write(key: 'auth_access_token', value: 'access-abc'),
      ).called(1);
      verify(
        () => mockStorage.write(key: 'auth_refresh_token', value: 'refresh-xyz'),
      ).called(1);
    });
  });

  group('getAccessToken', () {
    test('retorna el token si existeix', () async {
      when(
        () => mockStorage.read(key: 'auth_access_token'),
      ).thenAnswer((_) async => 'access-abc');

      final result = await datasource.getAccessToken();

      expect(result, 'access-abc');
    });

    test('retorna null si absent', () async {
      when(
        () => mockStorage.read(key: 'auth_access_token'),
      ).thenAnswer((_) async => null);

      final result = await datasource.getAccessToken();

      expect(result, isNull);
    });
  });

  group('getRefreshToken', () {
    test('retorna el token si existeix', () async {
      when(
        () => mockStorage.read(key: 'auth_refresh_token'),
      ).thenAnswer((_) async => 'refresh-xyz');

      final result = await datasource.getRefreshToken();

      expect(result, 'refresh-xyz');
    });

    test('retorna null si absent', () async {
      when(
        () => mockStorage.read(key: 'auth_refresh_token'),
      ).thenAnswer((_) async => null);

      final result = await datasource.getRefreshToken();

      expect(result, isNull);
    });
  });

  group('deleteAllTokens', () {
    test('esborra access, refresh i photo keys', () async {
      when(
        () => mockStorage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {});

      await datasource.deleteAllTokens();

      verify(() => mockStorage.delete(key: 'auth_access_token')).called(1);
      verify(() => mockStorage.delete(key: 'auth_refresh_token')).called(1);
      verify(() => mockStorage.delete(key: 'auth_photo_url')).called(1);
    });
  });

  group('savePhotoUrl', () {
    test('escriu la URL quan no és null', () async {
      when(
        () => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')),
      ).thenAnswer((_) async {});

      await datasource.savePhotoUrl('https://example.com/photo.jpg');

      verify(
        () => mockStorage.write(
          key: 'auth_photo_url',
          value: 'https://example.com/photo.jpg',
        ),
      ).called(1);
    });

    test('esborra el key quan és null', () async {
      when(
        () => mockStorage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {});

      await datasource.savePhotoUrl(null);

      verify(() => mockStorage.delete(key: 'auth_photo_url')).called(1);
      verifyNever(
        () => mockStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      );
    });
  });

  group('getPhotoUrl', () {
    test('retorna la URL si existeix', () async {
      when(
        () => mockStorage.read(key: 'auth_photo_url'),
      ).thenAnswer((_) async => 'https://example.com/photo.jpg');

      final result = await datasource.getPhotoUrl();

      expect(result, 'https://example.com/photo.jpg');
    });

    test('retorna null si absent', () async {
      when(
        () => mockStorage.read(key: 'auth_photo_url'),
      ).thenAnswer((_) async => null);

      expect(await datasource.getPhotoUrl(), isNull);
    });
  });

  group('saveUserId', () {
    test('escriu el userId quan no és null', () async {
      when(
        () => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')),
      ).thenAnswer((_) async {});

      await datasource.saveUserId('user-123');

      verify(
        () => mockStorage.write(key: 'auth_user_id', value: 'user-123'),
      ).called(1);
    });

    test('escriu null quan el valor és null', () async {
      when(
        () => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')),
      ).thenAnswer((_) async {});

      await datasource.saveUserId(null);

      verify(
        () => mockStorage.write(key: 'auth_user_id', value: null),
      ).called(1);
    });
  });

  group('getUserId', () {
    test('retorna el userId si existeix', () async {
      when(
        () => mockStorage.read(key: 'auth_user_id'),
      ).thenAnswer((_) async => 'user-123');

      expect(await datasource.getUserId(), 'user-123');
    });

    test('retorna null si absent', () async {
      when(
        () => mockStorage.read(key: 'auth_user_id'),
      ).thenAnswer((_) async => null);

      expect(await datasource.getUserId(), isNull);
    });
  });
}
