class EnvConfig {
  EnvConfig._();

  static const String env = String.fromEnvironment('env');

  static const String serverUrl = String.fromEnvironment('server_url');

  static const String googleWebClientId = String.fromEnvironment(
    'google_web_client_id',
  );

  static const String iosClientId = String.fromEnvironment('ios_client_id');

  static const String termsAndConditionsUrl = String.fromEnvironment(
    'terms_url',
  );

  static const String privacyUrl = String.fromEnvironment('privacy_url');

  static const String helpUrl = String.fromEnvironment('help_url');

  static const String aboutUrl = String.fromEnvironment('about_url');
}
