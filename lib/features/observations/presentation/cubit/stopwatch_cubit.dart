import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StopwatchCubit extends Cubit<Duration> with WidgetsBindingObserver {
  StopwatchCubit({required this.startTime}) : super(Duration.zero) {
    WidgetsBinding.instance.addObserver(this);
    _startTimer();
  }

  final DateTime startTime;
  Timer? _timer;

  Duration _elapsed() {
    final diff = DateTime.now().difference(startTime);
    return diff.isNegative ? Duration.zero : diff;
  }

  void _startTimer() {
    _timer?.cancel();
    emit(_elapsed());
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => emit(_elapsed()),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        _timer?.cancel();
        _timer = null;
      case AppLifecycleState.resumed:
        _startTimer();
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    return super.close();
  }
}
