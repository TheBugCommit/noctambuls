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
    final diff = DateTime.now().toUtc().difference(startTime);
    if (diff.isNegative) return Duration.zero;

    return Duration(seconds: diff.inSeconds);
  }

  void _startTimer() {
    _timer?.cancel();
    emit(_elapsed());

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final newDuration = _elapsed();
        if (state != newDuration) {
          emit(newDuration);
        }
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startTimer();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      _timer?.cancel();
      _timer = null;
    }
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    return super.close();
  }
}
