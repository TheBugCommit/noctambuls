import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/error/failure.dart';

sealed class CatalogSyncState extends Equatable {
  const CatalogSyncState();

  @override
  List<Object?> get props => [];
}

final class CatalogSyncInitial extends CatalogSyncState {
  const CatalogSyncInitial();
}

final class CatalogSyncInProgress extends CatalogSyncState {
  const CatalogSyncInProgress();
}

final class CatalogSyncSuccess extends CatalogSyncState {
  const CatalogSyncSuccess();
}

final class CatalogSyncFailure extends CatalogSyncState {
  const CatalogSyncFailure({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
