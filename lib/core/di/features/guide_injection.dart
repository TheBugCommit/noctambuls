import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/features/guide/data/datasources/birds_local_datasource.dart';
import 'package:noctambuls/features/guide/data/repositories/birds_repository_impl.dart';
import 'package:noctambuls/features/guide/domain/repositories/birds_repository.dart';
import 'package:noctambuls/features/guide/domain/usecases/get_birds_usecase.dart';
import 'package:noctambuls/features/guide/presentation/bloc/guide_bloc.dart';

void initGuideFeature() {
  sl
    ..registerLazySingleton<BirdsLocalDataSource>(
      () => BirdsLocalDataSourceDriftImpl(db: sl()),
    )
    ..registerLazySingleton<BirdsRepository>(
      () => BirdsRepositoryImpl(localDataSource: sl()),
    )
    ..registerLazySingleton(() => GetBirdsUseCase(sl()))
    ..registerFactory(
      () => GuideBloc(getBirdsUseCase: sl(), audioService: sl()),
    );
}
