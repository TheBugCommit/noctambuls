import 'package:equatable/equatable.dart';

sealed class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object?> get props => [];
}

final class CheckInternetConnectionEvent extends ConnectivityEvent {
  const CheckInternetConnectionEvent();
}
