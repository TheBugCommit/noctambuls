import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:noctambuls/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:noctambuls/features/profile/data/models/update_profile_request_model.dart';
import 'package:noctambuls/features/profile/data/models/user_profile_model.dart';
import 'package:noctambuls/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:noctambuls/features/profile/domain/entities/user_profile.dart';
import 'package:noctambuls/features/profile/domain/failures/profile_failures.dart';
import 'package:noctambuls/features/profile/domain/usecases/update_profile_usecase.dart';

class MockProfileRemoteDataSource extends Mock
    implements ProfileRemoteDataSource {}

class MockProfileLocalDataSource extends Mock
    implements ProfileLocalDataSource {}

class FakeUserProfileModel extends Fake implements UserProfileModel {}

class FakeUpdateProfileRequestModel extends Fake
    implements UpdateProfileRequestModel {}

void main() {
  late MockProfileRemoteDataSource mockRemote;
  late MockProfileLocalDataSource mockLocal;
  late ProfileRepositoryImpl repo;

  const tUserId = 'u1';
  final tCreatedAt = DateTime.utc(2024, 1, 15, 10);

  final tModel = UserProfileModel(
    id: 'u1',
    name: 'Anna',
    phone: '600000001',
    createdAt: tCreatedAt,
  );
  final tProfile = tModel.toDomain();

  final tUpdatedModel = UserProfileModel(
    id: 'u1',
    name: 'Bob',
    phone: '700000002',
    createdAt: tCreatedAt,
  );
  final tUpdatedProfile = tUpdatedModel.toDomain();

  DioException networkError() => DioException(
        requestOptions: RequestOptions(path: '/api/profile/$tUserId'),
        type: DioExceptionType.connectionError,
      );

  DioException httpError(int code, [Map<String, dynamic>? data]) =>
      DioException(
        requestOptions: RequestOptions(path: '/api/profile/$tUserId'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/api/profile/$tUserId'),
          statusCode: code,
          data: data ?? <String, dynamic>{},
        ),
      );

  // 404 with backend-structured body → isOurBackendError=true → ProfileNotFoundFailure
  final backend404 = httpError(
    404,
    {'message': 'not found', 'code': 'NOT_FOUND', 'details': <String, dynamic>{}},
  );

  // 400 with backend-structured body → ProfileUpdateFailure
  final backend400 = httpError(
    400,
    {'message': 'bad request', 'code': 'BAD_REQUEST', 'details': <String, dynamic>{}},
  );

  setUpAll(() {
    registerFallbackValue(FakeUserProfileModel());
    registerFallbackValue(FakeUpdateProfileRequestModel());
  });

  setUp(() {
    mockRemote = MockProfileRemoteDataSource();
    mockLocal = MockProfileLocalDataSource();
    repo = ProfileRepositoryImpl(remote: mockRemote, local: mockLocal);
  });

  group('getProfile', () {
    test('cache hit → Ok(profile), remote no cridat', () async {
      when(() => mockLocal.getProfile(tUserId))
          .thenAnswer((_) async => tModel);

      final result = await repo.getProfile(tUserId);

      expect(result, isA<Ok<UserProfile>>());
      expect((result as Ok<UserProfile>).value, tProfile);
      verifyNever(() => mockRemote.getProfile(any()));
      verifyNever(() => mockLocal.saveProfile(any()));
    });

    test('cache miss → remote OK → saveProfile cridat → Ok(profile)', () async {
      when(() => mockLocal.getProfile(tUserId)).thenAnswer((_) async => null);
      when(() => mockRemote.getProfile(tUserId))
          .thenAnswer((_) async => tModel);
      when(() => mockLocal.saveProfile(any())).thenAnswer((_) async {});

      final result = await repo.getProfile(tUserId);

      expect(result, isA<Ok<UserProfile>>());
      expect((result as Ok<UserProfile>).value, tProfile);
      verify(() => mockLocal.saveProfile(any())).called(1);
    });

    test('cache miss → DioException xarxa → Err(ProfileNetworkFailure) amb statusCode=0',
        () async {
      when(() => mockLocal.getProfile(tUserId)).thenAnswer((_) async => null);
      when(() => mockRemote.getProfile(tUserId)).thenThrow(networkError());

      final result = await repo.getProfile(tUserId);

      expect(result, isA<Err<UserProfile>>());
      final failure = (result as Err<UserProfile>).failure;
      expect(failure, isA<ProfileNetworkFailure>());
    });

    test('cache miss → DioException 500 → Err(ProfileNetworkFailure)', () async {
      when(() => mockLocal.getProfile(tUserId)).thenAnswer((_) async => null);
      when(() => mockRemote.getProfile(tUserId))
          .thenThrow(httpError(500));

      final result = await repo.getProfile(tUserId);

      expect(result, isA<Err<UserProfile>>());
      expect((result as Err<UserProfile>).failure, isA<ProfileNetworkFailure>());
    });

    test('cache miss → DioException 404 (backend propi) → Err(ProfileNotFoundFailure)',
        () async {
      when(() => mockLocal.getProfile(tUserId)).thenAnswer((_) async => null);
      when(() => mockRemote.getProfile(tUserId)).thenThrow(backend404);

      final result = await repo.getProfile(tUserId);

      expect(result, isA<Err<UserProfile>>());
      expect(
        (result as Err<UserProfile>).failure,
        isA<ProfileNotFoundFailure>(),
      );
    });

    test('cache miss → excepció genèrica → Err(ProfileNetworkFailure)', () async {
      when(() => mockLocal.getProfile(tUserId)).thenAnswer((_) async => null);
      when(() => mockRemote.getProfile(tUserId))
          .thenThrow(Exception('error inesperat'));

      final result = await repo.getProfile(tUserId);

      expect(result, isA<Err<UserProfile>>());
      expect((result as Err<UserProfile>).failure, isA<ProfileNetworkFailure>());
    });

    test('cache hit → saveProfile NO es crida mai', () async {
      when(() => mockLocal.getProfile(tUserId)).thenAnswer((_) async => tModel);

      await repo.getProfile(tUserId);

      verifyNever(() => mockLocal.saveProfile(any()));
    });
  });

  group('updateProfile', () {
    const tParams = UpdateProfileParams(
      userId: tUserId,
      name: 'Bob',
      phone: '700000002',
    );

    test('remote OK → saveProfile cridat → Ok(updatedProfile)', () async {
      when(() => mockRemote.updateProfile(tUserId, any()))
          .thenAnswer((_) async => tUpdatedModel);
      when(() => mockLocal.saveProfile(any())).thenAnswer((_) async {});

      final result = await repo.updateProfile(tUserId, tParams);

      expect(result, isA<Ok<UserProfile>>());
      expect((result as Ok<UserProfile>).value, tUpdatedProfile);
      verify(() => mockLocal.saveProfile(any())).called(1);
    });

    test('crida remote.updateProfile amb userId i request model correctes',
        () async {
      when(() => mockRemote.updateProfile(tUserId, any()))
          .thenAnswer((_) async => tUpdatedModel);
      when(() => mockLocal.saveProfile(any())).thenAnswer((_) async {});

      await repo.updateProfile(tUserId, tParams);

      final captured = verify(
        () => mockRemote.updateProfile(tUserId, captureAny()),
      ).captured;
      final requestModel = captured.single as UpdateProfileRequestModel;
      expect(requestModel.name, tParams.name);
      expect(requestModel.phone, tParams.phone);
    });

    test('DioException xarxa → Err(ProfileNetworkFailure)', () async {
      when(() => mockRemote.updateProfile(tUserId, any()))
          .thenThrow(networkError());

      final result = await repo.updateProfile(tUserId, tParams);

      expect(result, isA<Err<UserProfile>>());
      expect((result as Err<UserProfile>).failure, isA<ProfileNetworkFailure>());
    });

    test('DioException 400 (backend propi) → Err(ProfileUpdateFailure)', () async {
      when(() => mockRemote.updateProfile(tUserId, any()))
          .thenThrow(backend400);

      final result = await repo.updateProfile(tUserId, tParams);

      expect(result, isA<Err<UserProfile>>());
      final failure = (result as Err<UserProfile>).failure as ProfileUpdateFailure;
      expect(failure.statusCode, 400);
    });

    test('excepció genèrica → Err(ProfileUpdateFailure)', () async {
      when(() => mockRemote.updateProfile(tUserId, any()))
          .thenThrow(Exception('error inesperat'));

      final result = await repo.updateProfile(tUserId, tParams);

      expect(result, isA<Err<UserProfile>>());
      expect((result as Err<UserProfile>).failure, isA<ProfileUpdateFailure>());
    });
  });
}
