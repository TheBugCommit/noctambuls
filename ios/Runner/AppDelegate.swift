import Flutter
import UIKit
import flutter_local_notifications
import workmanager_apple
import FirebaseCore

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    WorkmanagerPlugin.registerPeriodicTask(
        withIdentifier: "syncPendingSessionsTask",
        frequency: NSNumber(value: 6 * 60 * 60)
    )
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
      FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
            GeneratedPluginRegistrant.register(with: registry)
      }
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
