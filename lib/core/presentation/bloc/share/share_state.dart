import 'package:equatable/equatable.dart';

sealed class ShareState extends Equatable {
  const ShareState();

  @override
  List<Object?> get props => [];
}

final class ShareInitial extends ShareState {
  const ShareInitial();
}

final class ShareSuccess extends ShareState {
  const ShareSuccess();
}

final class ShareDismissed extends ShareState {
  const ShareDismissed();
}

final class ShareFailure extends ShareState {
  const ShareFailure();
}
