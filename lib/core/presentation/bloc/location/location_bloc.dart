import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/domain/usecases/location/capture_location_usecase.dart';
import 'package:noctambuls/core/domain/usecases/location/watch_location_usecase.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_event.dart';
import 'package:noctambuls/core/presentation/bloc/location/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc({
    required CaptureLocationUseCase getLocation,
    required WatchLocationUseCase watchLocationStream,
  }) : _getLocation = getLocation,
       _watchLocationStream = watchLocationStream,
       super(LocationInitial()) {
    on<LocationRequested>(_onLocationRequested);
    on<LocationTrackingStarted>(_onLocationTrackingStarted);
    on<LocationTrackingStopped>(_onLocationTrackingStopped);
    on<LocationPositionUpdated>(_onLocationPositionUpdated);
  }

  final CaptureLocationUseCase _getLocation;
  final WatchLocationUseCase _watchLocationStream;

  StreamSubscription<GeoPosition>? _positionSubscription;

  Future<void> _onLocationRequested(
    LocationRequested event,
    Emitter<LocationState> emit,
  ) async {
    if (state is LocationLoadSuccess &&
        (state as LocationLoadSuccess).isTracking) {
      return;
    }

    emit(LocationLoadInProgress());

    final result = await _getLocation();

    result.when(
      success: (position) =>
          emit(LocationLoadSuccess(position: position, isTracking: false)),
      failure: (failure) => emit(LocationLoadFailure(failure)),
    );
  }

  Future<void> _onLocationTrackingStarted(
    LocationTrackingStarted event,
    Emitter<LocationState> emit,
  ) async {
    if (state is LocationLoadSuccess &&
        (state as LocationLoadSuccess).isTracking) {
      return;
    }

    emit(LocationLoadInProgress());

    final initialResult = await _getLocation();
    if (initialResult is Err<GeoPosition>) {
      emit(LocationLoadFailure(initialResult.failure));
      return;
    }
    if (initialResult is Ok<GeoPosition>) {
      emit(
        LocationLoadSuccess(position: initialResult.value, isTracking: true),
      );
    }

    await _positionSubscription?.cancel();

    _positionSubscription = _watchLocationStream().listen(
      (position) {
        add(LocationPositionUpdated(position));
      },
      onError: (error) {
        add(LocationTrackingStopped());
      },
    );
  }

  void _onLocationPositionUpdated(
    LocationPositionUpdated event,
    Emitter<LocationState> emit,
  ) {
    if (state is LocationLoadSuccess) {
      emit(LocationLoadSuccess(position: event.position, isTracking: true));
    }
  }

  Future<void> _onLocationTrackingStopped(
    LocationTrackingStopped event,
    Emitter<LocationState> emit,
  ) async {
    await _positionSubscription?.cancel();
    _positionSubscription = null;

    if (state is LocationLoadSuccess) {
      final currentState = state as LocationLoadSuccess;
      emit(currentState.copyWith(isTracking: false));
    }
  }

  @override
  Future<void> close() {
    unawaited(_positionSubscription?.cancel());
    return super.close();
  }
}
