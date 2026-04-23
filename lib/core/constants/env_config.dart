class EnvConfig {
  EnvConfig._();

  static const String env = String.fromEnvironment('env');

  static const String serverUrl = String.fromEnvironment('server_url');

  static const String googleWebClientId = String.fromEnvironment(
    'google_web_client_id',
  );
}
