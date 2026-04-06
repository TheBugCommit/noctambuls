import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    developer.log('⚡ EVENT: ${event.runtimeType}', name: 'BLoC');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    //developer.log('🔄 CHANGE (${bloc.runtimeType}): $change', name: 'BLoC');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    developer.log(
      '🚀 TRANSITION (${bloc.runtimeType}):\n'
      '    De: ${transition.currentState.runtimeType}\n'
      '    Event: ${transition.event.runtimeType}\n'
      '    A: ${transition.nextState.runtimeType}',
      name: 'BLoC',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    developer.log(
      '❌ ERROR (${bloc.runtimeType}): $error',
      name: 'BLoC',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
