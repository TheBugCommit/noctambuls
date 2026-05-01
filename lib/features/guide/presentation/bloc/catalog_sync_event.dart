import 'package:equatable/equatable.dart';

sealed class CatalogSyncEvent extends Equatable {
  const CatalogSyncEvent();

  @override
  List<Object?> get props => [];
}

final class CatalogSyncEventRequest extends CatalogSyncEvent {
  const CatalogSyncEventRequest({this.showGlobalError = false});

  final bool showGlobalError;

  @override
  List<Object?> get props => [showGlobalError];
}
