import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/domain/usecases/open_url_usecase.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_event.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_state.dart';

class UrlBloc extends Bloc<UrlEvent, UrlState> {
  UrlBloc({required this.openUrlUseCase, required this.logger})
    : super(const UrlInitial()) {
    on<OpenUrlRequested>(_onOpenUrlRequested);
  }

  final OpenUrlUseCase openUrlUseCase;
  final IAppLogger logger;

  Future<void> _onOpenUrlRequested(
    OpenUrlRequested event,
    Emitter<UrlState> emit,
  ) async {
    emit(const UrlInitial());
    final result = await openUrlUseCase(event.url);

    result.when(
      success: (_) {
        emit(const UrlActionSuccess());
      },
      failure: (failure) {
        emit(const UrlActionFailure());
        logger.failure(failure);
      },
    );
  }
}
