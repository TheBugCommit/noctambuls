import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/auth/data/datasources/token_local_datasource.dart';
import 'package:noctambuls/features/auth/data/network/auth_interceptor.dart';
import 'package:noctambuls/features/auth/data/network/token_refresh_manager.dart';

import '../../helpers/jwt_helper.dart';

class FakeFailure extends Fake implements Failure {}

class MockTokenLocalDataSource extends Mock implements TokenLocalDataSource {}

class MockTokenRefreshManager extends Mock implements TokenRefreshManager {}

class MockIAppLogger extends Mock implements IAppLogger {}

class MockDio extends Mock implements Dio {}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

void main() {
  late MockTokenLocalDataSource mockLocal;
  late MockTokenRefreshManager mockRefreshManager;
  late MockIAppLogger mockLogger;
  late MockDio mockDio;
  late AuthInterceptor interceptor;
  late bool sessionExpiredCalled;

  final tFutureJwt = makeJwt(id: 'u1', email: 'a@b.cat', exp: futureExp);
  final tExpiringSoonJwt = makeJwt(
    id: 'u1',
    email: 'a@b.cat',
    exp: DateTime.now().add(const Duration(minutes: 2)).millisecondsSinceEpoch ~/
        1000,
  );

  setUpAll(() {
    registerFallbackValue(RequestOptions());
    registerFallbackValue(DioException(requestOptions: RequestOptions()));
    registerFallbackValue(FakeFailure());
    registerFallbackValue(Response<dynamic>(requestOptions: RequestOptions()));
  });

  setUp(() {
    mockLocal = MockTokenLocalDataSource();
    mockRefreshManager = MockTokenRefreshManager();
    mockLogger = MockIAppLogger();
    mockDio = MockDio();
    sessionExpiredCalled = false;
    interceptor = AuthInterceptor(
      tokenLocalDataSource: mockLocal,
      refreshManager: mockRefreshManager,
      onSessionExpired: () => sessionExpiredCalled = true,
      logger: mockLogger,
    )..dio = mockDio;
  });

  group('onRequest', () {
    test('sense accessToken → no afegeix header Authorization', () async {
      when(() => mockLocal.getAccessToken()).thenAnswer((_) async => null);
      final handler = MockRequestInterceptorHandler();
      when(() => handler.next(any())).thenReturn(null);
      final options = RequestOptions(path: '/test');

      await interceptor.onRequest(options, handler);

      final captured = verify(() => handler.next(captureAny())).captured;
      final capturedOptions = captured.single as RequestOptions;
      expect(capturedOptions.headers.containsKey('Authorization'), isFalse);
    });

    test(
      'token vàlid (expira en >5min) → afegeix header Bearer, no refresca',
      () async {
        when(() => mockLocal.getAccessToken()).thenAnswer((_) async => tFutureJwt);
        final handler = MockRequestInterceptorHandler();
        when(() => handler.next(any())).thenReturn(null);
        final options = RequestOptions(path: '/test');

        await interceptor.onRequest(options, handler);

        verifyNever(() => mockRefreshManager.refreshToken());
        final captured = verify(() => handler.next(captureAny())).captured;
        final capturedOptions = captured.single as RequestOptions;
        expect(capturedOptions.headers['Authorization'], 'Bearer $tFutureJwt');
      },
    );

    test(
      'token expira en <5min → refresh proactiu i usa el nou token',
      () async {
        when(() => mockLocal.getAccessToken())
            .thenAnswer((_) async => tExpiringSoonJwt);
        when(() => mockRefreshManager.refreshToken())
            .thenAnswer((_) async => 'new-token');
        final handler = MockRequestInterceptorHandler();
        when(() => handler.next(any())).thenReturn(null);
        final options = RequestOptions(path: '/test');

        await interceptor.onRequest(options, handler);

        verify(() => mockRefreshManager.refreshToken()).called(1);
        final captured = verify(() => handler.next(captureAny())).captured;
        final capturedOptions = captured.single as RequestOptions;
        expect(capturedOptions.headers['Authorization'], 'Bearer new-token');
      },
    );

    test(
      'refresh proactiu retorna null → usa el token original',
      () async {
        when(() => mockLocal.getAccessToken())
            .thenAnswer((_) async => tExpiringSoonJwt);
        when(() => mockRefreshManager.refreshToken()).thenAnswer((_) async => null);
        final handler = MockRequestInterceptorHandler();
        when(() => handler.next(any())).thenReturn(null);
        final options = RequestOptions(path: '/test');

        await interceptor.onRequest(options, handler);

        final captured = verify(() => handler.next(captureAny())).captured;
        final capturedOptions = captured.single as RequestOptions;
        expect(
          capturedOptions.headers['Authorization'],
          'Bearer $tExpiringSoonJwt',
        );
      },
    );

    test(
      'JWT malformat → refresh i usa nou token',
      () async {
        when(() => mockLocal.getAccessToken())
            .thenAnswer((_) async => 'invalid.jwt');
        when(() => mockRefreshManager.refreshToken())
            .thenAnswer((_) async => 'fresh-token');
        final handler = MockRequestInterceptorHandler();
        when(() => handler.next(any())).thenReturn(null);
        final options = RequestOptions(path: '/test');

        await interceptor.onRequest(options, handler);

        verify(() => mockRefreshManager.refreshToken()).called(1);
        final captured = verify(() => handler.next(captureAny())).captured;
        final capturedOptions = captured.single as RequestOptions;
        expect(capturedOptions.headers['Authorization'], 'Bearer fresh-token');
      },
    );

    test(
      'error de xarxa durant refresh → loga i continua amb token original',
      () async {
        when(() => mockLocal.getAccessToken())
            .thenAnswer((_) async => tExpiringSoonJwt);
        when(() => mockRefreshManager.refreshToken()).thenThrow(
          DioException(requestOptions: RequestOptions()),
        );
        when(() => mockLogger.failure(any())).thenReturn(null);
        final handler = MockRequestInterceptorHandler();
        when(() => handler.next(any())).thenReturn(null);
        final options = RequestOptions(path: '/test');

        await interceptor.onRequest(options, handler);

        verify(() => mockLogger.failure(any())).called(1);
        final captured = verify(() => handler.next(captureAny())).captured;
        final capturedOptions = captured.single as RequestOptions;
        expect(
          capturedOptions.headers['Authorization'],
          'Bearer $tExpiringSoonJwt',
        );
      },
    );

    test(
      'request de reintent → no refresh proactiu',
      () async {
        when(() => mockLocal.getAccessToken()).thenAnswer((_) async => tFutureJwt);
        final handler = MockRequestInterceptorHandler();
        when(() => handler.next(any())).thenReturn(null);
        final options = RequestOptions(
          path: '/test',
          extra: {'auth_interceptor_retry': true},
        );

        await interceptor.onRequest(options, handler);

        verifyNever(() => mockRefreshManager.refreshToken());
      },
    );
  });

  group('onError', () {
    test(
      'error 401 (no reintent) → refresh i resol amb resposta reintentada',
      () async {
        final options = RequestOptions(path: '/test');
        final err = DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 401),
        );
        when(() => mockRefreshManager.refreshToken())
            .thenAnswer((_) async => 'new-token');
        when(() => mockLocal.getAccessToken())
            .thenAnswer((_) async => 'new-token');
        final fakeResponse = Response<dynamic>(
          requestOptions: options,
          statusCode: 200,
        );
        when(() => mockDio.fetch<dynamic>(any()))
            .thenAnswer((_) async => fakeResponse);
        final handler = MockErrorInterceptorHandler();
        when(() => handler.resolve(any())).thenReturn(null);

        await interceptor.onError(err, handler);

        verify(() => handler.resolve(fakeResponse)).called(1);
      },
    );

    test(
      'error 401, refresh retorna null → crida onSessionExpired',
      () async {
        final options = RequestOptions(path: '/test');
        final err = DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 401),
        );
        when(() => mockRefreshManager.refreshToken()).thenAnswer((_) async => null);
        final handler = MockErrorInterceptorHandler();
        when(() => handler.next(any())).thenReturn(null);

        await interceptor.onError(err, handler);

        expect(sessionExpiredCalled, isTrue);
      },
    );

    test(
      'error 401, refresh llença → loga i fa handler.next',
      () async {
        final options = RequestOptions(path: '/test');
        final err = DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 401),
        );
        when(() => mockRefreshManager.refreshToken()).thenThrow(
          DioException(requestOptions: RequestOptions()),
        );
        when(() => mockLogger.failure(any())).thenReturn(null);
        final handler = MockErrorInterceptorHandler();
        when(() => handler.next(any())).thenReturn(null);

        await interceptor.onError(err, handler);

        verify(() => mockLogger.failure(any())).called(1);
        verify(() => handler.next(err)).called(1);
      },
    );

    test(
      'error 401, ja és reintent → handler.next directament',
      () async {
        final options = RequestOptions(
          path: '/test',
          extra: {'auth_interceptor_retry': true},
        );
        final err = DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 401),
        );
        final handler = MockErrorInterceptorHandler();
        when(() => handler.next(any())).thenReturn(null);

        await interceptor.onError(err, handler);

        verifyNever(() => mockRefreshManager.refreshToken());
        verify(() => handler.next(err)).called(1);
      },
    );

    test(
      'error no-401 → handler.next sense refresh',
      () async {
        final options = RequestOptions(path: '/test');
        final err = DioException(
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: 500),
        );
        final handler = MockErrorInterceptorHandler();
        when(() => handler.next(any())).thenReturn(null);

        await interceptor.onError(err, handler);

        verifyNever(() => mockRefreshManager.refreshToken());
        verify(() => handler.next(err)).called(1);
      },
    );
  });
}
