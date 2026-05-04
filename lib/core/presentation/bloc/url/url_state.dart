import 'package:equatable/equatable.dart';

sealed class UrlState extends Equatable {
  const UrlState();

  @override
  List<Object?> get props => [];
}

final class UrlInitial extends UrlState {
  const UrlInitial();
}

final class UrlActionSuccess extends UrlState {
  const UrlActionSuccess();
}

final class UrlActionFailure extends UrlState {
  const UrlActionFailure();
}
