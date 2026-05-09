import 'package:equatable/equatable.dart';

sealed class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object?> get props => [];
}

final class NetworkActionInitial extends ConnectivityState {
  const NetworkActionInitial();
}

final class NetworkActionLoading extends ConnectivityState {
  const NetworkActionLoading();
}

final class NetworkActionSuccess extends ConnectivityState {
  const NetworkActionSuccess();
}

final class NetworkActionFailure extends ConnectivityState {
  const NetworkActionFailure();
}
