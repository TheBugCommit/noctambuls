import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';

sealed class ObservationFormState extends Equatable {
  const ObservationFormState();

  @override
  List<Object?> get props => [];
}

final class ObservationFormInitial extends ObservationFormState {
  const ObservationFormInitial();
}

final class ObservationFormLoading extends ObservationFormState {
  const ObservationFormLoading();
}

final class ObservationFormReady extends ObservationFormState {
  const ObservationFormReady({required this.birds});

  final List<Bird> birds;

  @override
  List<Object?> get props => [birds];
}

final class ObservationFormSuccess extends ObservationFormState {
  const ObservationFormSuccess();
}

final class ObservationFormError extends ObservationFormState {
  const ObservationFormError({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
