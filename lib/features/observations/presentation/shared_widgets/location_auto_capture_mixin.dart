import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

mixin LocationAutoCaptureMixin<T extends StatefulWidget>
    on State<T>, WidgetsBindingObserver {
  bool get shouldRetryLocationCapture;

  Future<void> onResumedLocationCapture();

  Future<void> onPausedLocationCapture() async {}

  StreamSubscription<ServiceStatus>? _serviceStatusSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _serviceStatusSubscription = Geolocator.getServiceStatusStream().listen(
      (status) {
        if (status == ServiceStatus.enabled) {
          if (mounted && shouldRetryLocationCapture) {
            unawaited(onResumedLocationCapture());
          }
        }
      },
    );
  }

  @override
  void dispose() {
    unawaited(_serviceStatusSubscription?.cancel());
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (shouldRetryLocationCapture) {
        unawaited(onResumedLocationCapture());
      } else {
        unawaited(_retryIfPermissionJustGranted());
      }
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      unawaited(onPausedLocationCapture());
    }
  }

  Future<void> _retryIfPermissionJustGranted() async {
    if (!mounted) return;
    final permission = await Geolocator.checkPermission();
    if (!mounted) return;
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      unawaited(onResumedLocationCapture());
    }
  }

  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeLocales(List<Locale>? locales) {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didChangeTextScaleFactor() {}

  @override
  void didHaveMemoryPressure() {}

  @override
  Future<bool> didPopRoute() => Future.value(false);

  @override
  Future<bool> didPushRoute(String route) => Future.value(false);

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) =>
      Future.value(false);
}
