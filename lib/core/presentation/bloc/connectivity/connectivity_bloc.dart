import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/domain/usecases/connectivity/check_internet_connection_usecase.dart';
import 'package:noctambuls/core/presentation/bloc/connectivity/connectivity_event.dart';
import 'package:noctambuls/core/presentation/bloc/connectivity/connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc({
    required this.checkInternetConnectionUseCase,
  }) : super(const NetworkActionInitial()) {
    on<CheckInternetConnectionEvent>(
      _onCheckInternetConnection,
    );
  }

  final CheckInternetConnectionUseCase checkInternetConnectionUseCase;

  Future<void> _onCheckInternetConnection(
    CheckInternetConnectionEvent event,
    Emitter<ConnectivityState> emit,
  ) async {
    emit(const NetworkActionLoading());

    final hasConnection = await checkInternetConnectionUseCase();
    if (hasConnection) {
      emit(const NetworkActionSuccess());
      return;
    }
    emit(const NetworkActionFailure());
  }
}
