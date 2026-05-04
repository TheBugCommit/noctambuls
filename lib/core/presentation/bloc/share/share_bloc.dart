import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/domain/usecases/share/share_text_usecase.dart';
import 'package:noctambuls/core/domain/usecases/share/share_uri_usecase.dart';
import 'package:noctambuls/core/presentation/bloc/share/share_event.dart';
import 'package:noctambuls/core/presentation/bloc/share/share_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  ShareBloc({
    required this.shareTextUseCase,
    required this.shareUriUseCase,
  }) : super(const ShareInitial()) {
    on<ShareTextRequested>(_onShareTextRequested);
    on<ShareUriRequested>(_onShareUriRequested);
  }

  final ShareTextUseCase shareTextUseCase;
  final ShareUriUseCase shareUriUseCase;

  Future<void> _onShareTextRequested(
    ShareTextRequested event,
    Emitter<ShareState> emit,
  ) async {
    emit(const ShareInitial());

    try {
      final result = await shareTextUseCase(
        text: event.text,
        subject: event.subject,
      );
      result.when(
        success: (_) => emit(const ShareSuccess()),
        failure: (_) => emit(const ShareDismissed()),
      );
    } catch (_) {
      emit(const ShareFailure());
    }
  }

  Future<void> _onShareUriRequested(
    ShareUriRequested event,
    Emitter<ShareState> emit,
  ) async {
    emit(const ShareInitial());

    try {
      final result = await shareUriUseCase(uri: event.uri);
      result.when(
        success: (_) => emit(const ShareSuccess()),
        failure: (_) => emit(const ShareDismissed()),
      );
    } catch (_) {
      emit(const ShareFailure());
    }
  }
}
