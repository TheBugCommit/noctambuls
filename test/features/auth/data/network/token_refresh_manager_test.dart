import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:noctambuls/features/auth/data/datasources/token_local_datasource.dart';
import 'package:noctambuls/features/auth/data/models/refresh_token_request_model.dart';
import 'package:noctambuls/features/auth/data/models/refresh_token_response_model.dart';
import 'package:noctambuls/features/auth/data/network/token_refresh_manager.dart';

class MockTokenLocalDataSource extends Mock implements TokenLocalDataSource {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class FakeRefreshTokenRequestModel extends Fake
    implements RefreshTokenRequestModel {}

void main() {
  late MockTokenLocalDataSource mockLocal;
  late MockAuthRemoteDataSource mockRemote;
  late TokenRefreshManager manager;

  const tRefreshToken = 'refresh-token-abc';
  const tNewAccessToken = 'new-access-token';
  const tNewRefreshToken = 'new-refresh-token';

  final tRefreshResponse = RefreshTokenResponseModel(
    accessToken: tNewAccessToken,
    refreshToken: tNewRefreshToken,
  );

  setUpAll(() {
    registerFallbackValue(FakeRefreshTokenRequestModel());
  });

  setUp(() {
    mockLocal = MockTokenLocalDataSource();
    mockRemote = MockAuthRemoteDataSource();
    manager = TokenRefreshManager(
      tokenLocalDataSource: mockLocal,
      authRemoteDataSource: mockRemote,
    );
  });

  group('refreshToken', () {
    test('sense refresh token → retorna null sense cridar remote', () async {
      when(() => mockLocal.getRefreshToken()).thenAnswer((_) async => null);

      final result = await manager.refreshToken();

      expect(result, isNull);
      verifyNever(() => mockRemote.refreshTokens(any()));
    });

    test('refresh token vàlid → guarda nou parell i retorna nou accessToken',
        () async {
      when(() => mockLocal.getRefreshToken())
          .thenAnswer((_) async => tRefreshToken);
      when(() => mockRemote.refreshTokens(any()))
          .thenAnswer((_) async => tRefreshResponse);
      when(() => mockLocal.saveTokenPair(any(), any()))
          .thenAnswer((_) async {});

      final result = await manager.refreshToken();

      expect(result, tNewAccessToken);
      verify(
        () => mockLocal.saveTokenPair(tNewAccessToken, tNewRefreshToken),
      ).called(1);
    });

    test('resposta 401 → esborra tokens i retorna null', () async {
      when(() => mockLocal.getRefreshToken())
          .thenAnswer((_) async => tRefreshToken);
      when(() => mockRemote.refreshTokens(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          response: Response(
            requestOptions: RequestOptions(),
            statusCode: 401,
          ),
        ),
      );
      when(() => mockLocal.deleteAllTokens()).thenAnswer((_) async {});

      final result = await manager.refreshToken();

      expect(result, isNull);
      verify(() => mockLocal.deleteAllTokens()).called(1);
    });

    test('resposta 403 → esborra tokens i retorna null', () async {
      when(() => mockLocal.getRefreshToken())
          .thenAnswer((_) async => tRefreshToken);
      when(() => mockRemote.refreshTokens(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          response: Response(
            requestOptions: RequestOptions(),
            statusCode: 403,
          ),
        ),
      );
      when(() => mockLocal.deleteAllTokens()).thenAnswer((_) async {});

      final result = await manager.refreshToken();

      expect(result, isNull);
      verify(() => mockLocal.deleteAllTokens()).called(1);
    });

    test('error de xarxa (sense resposta) → rethrows DioException', () async {
      when(() => mockLocal.getRefreshToken())
          .thenAnswer((_) async => tRefreshToken);
      when(() => mockRemote.refreshTokens(any())).thenThrow(
        DioException(requestOptions: RequestOptions()),
      );

      expect(() => manager.refreshToken(), throwsA(isA<DioException>()));
    });

    test('crida concurrent → executa _performRefresh una sola vegada', () async {
      when(() => mockLocal.getRefreshToken())
          .thenAnswer((_) async => tRefreshToken);
      when(() => mockRemote.refreshTokens(any()))
          .thenAnswer((_) async => tRefreshResponse);
      when(() => mockLocal.saveTokenPair(any(), any()))
          .thenAnswer((_) async {});

      final results = await Future.wait([
        manager.refreshToken(),
        manager.refreshToken(),
        manager.refreshToken(),
      ]);

      expect(results, everyElement(tNewAccessToken));
      verify(() => mockRemote.refreshTokens(any())).called(1);
    });
  });
}
