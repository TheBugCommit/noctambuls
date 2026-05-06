import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/error/failure.dart';

sealed class CatalogSyncState extends Equatable {
  const CatalogSyncState();

  @override
  List<Object?> get props => [];
}

final class CatalogSyncInitial extends CatalogSyncState {
  const CatalogSyncInitial();
}

final class CatalogSyncInProgress extends CatalogSyncState {
  const CatalogSyncInProgress({
    required this.isCatalogEmpty,
  });

  final bool isCatalogEmpty;

  @override
  List<Object?> get props => [isCatalogEmpty];
}

final class CatalogSyncSuccess extends CatalogSyncState {
  const CatalogSyncSuccess();
}

final class CatalogSyncFailure extends CatalogSyncState {
  const CatalogSyncFailure({
    required this.failure,
    required this.isCatalogEmpty,
    required this.showGlobalError,
    required this.timestamp,
  });

  final Failure failure;
  final bool isCatalogEmpty;
  final bool showGlobalError;
  final DateTime timestamp;

  @override
  List<Object?> get props => [
    failure,
    isCatalogEmpty,
    showGlobalError,
    timestamp,
  ];
}
