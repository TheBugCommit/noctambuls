import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/domain/usecases/sync_catalog_usecase.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_state.dart';

class CatalogSyncBloc extends Bloc<CatalogSyncEvent, CatalogSyncState> {
  CatalogSyncBloc({required this.syncCatalogUseCase, required this.logger})
    : super(const CatalogSyncInitial()) {
    on<CatalogSyncEventRequest>(_onSyncCatalogRequested);
  }

  final SyncCatalogUseCase syncCatalogUseCase;
  final IAppLogger logger;

  Future<void> _onSyncCatalogRequested(
    CatalogSyncEventRequest event,
    Emitter<CatalogSyncState> emit,
  ) async {
    if (state is CatalogSyncInProgress) return;

    emit(const CatalogSyncInProgress());

    final result = await syncCatalogUseCase();

    result.when(
      success: (_) {
        emit(const CatalogSyncSuccess());
      },
      failure: (failure) {
        logger.failure(failure);
        emit(CatalogSyncFailure(failure: failure));
      },
    );
  }
}
