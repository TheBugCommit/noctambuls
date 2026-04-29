import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/logging/app_logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    AppLogger.instance.info('EVENT: ${event.runtimeType}');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    AppLogger.instance.info(
      'TRANSITION (${bloc.runtimeType}): '
      '${transition.currentState.runtimeType}'
      ' → ${transition.nextState.runtimeType}',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    AppLogger.instance.failure(
      const UnknownFailure().withDebug(error, stackTrace),
    );
    super.onError(bloc, error, stackTrace);
  }
}
