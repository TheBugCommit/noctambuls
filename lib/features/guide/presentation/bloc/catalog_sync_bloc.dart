import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/usecases/check_is_catalog_empty_usecase.dart';
import 'package:noctambuls/features/guide/domain/usecases/sync_catalog_usecase.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_state.dart';

class CatalogSyncBloc extends Bloc<CatalogSyncEvent, CatalogSyncState> {
  CatalogSyncBloc({
    required this.syncCatalogUseCase,
    required this.checkIsCatalogEmptyUseCase,
    required this.logger,
  }) : super(const CatalogSyncInitial()) {
    on<CatalogSyncEventRequest>(_onSyncCatalogRequested);
  }

  final SyncCatalogUseCase syncCatalogUseCase;
  final CheckIsCatalogEmptyUseCase checkIsCatalogEmptyUseCase;
  final IAppLogger logger;

  Future<void> _onSyncCatalogRequested(
    CatalogSyncEventRequest event,
    Emitter<CatalogSyncState> emit,
  ) async {
    if (state is CatalogSyncInProgress) return;

    emit(const CatalogSyncInProgress());

    final result = await syncCatalogUseCase();

    await result.when(
      success: (_) {
        emit(const CatalogSyncSuccess());
      },
      failure: (failure) async {
        logger.failure(failure);
        final isEmpty = await checkIsCatalogEmptyUseCase();

        emit(
          CatalogSyncFailure(
            failure: failure,
            isCatalogEmpty: isEmpty,
            showGlobalError: event.showGlobalError,
            timestamp: DateTime.now(),
          ),
        );
      },
    );
  }
}
