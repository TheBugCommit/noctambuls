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

  static const String packageName = String.fromEnvironment('package_name');

  static const String openStreetMapCopyright = String.fromEnvironment(
    'open_street_map_copyright',
  );

  static const String openTopoMapAbout = String.fromEnvironment(
    'open_topo_map_about',
  );

  static const String openStreetMapTiles = String.fromEnvironment(
    'open_street_map_tiles',
  );

  static const String openTopoMapTiles = String.fromEnvironment(
    'open_topo_map_tiles',
  );

  static const String openTopoMapTextAttribute = String.fromEnvironment(
    'open_topo_map_text_attribute',
  );

  static const String openTopoMapStyleAttribute = String.fromEnvironment(
    'open_topo_map_style_attribute',
  );

  static const String openStreetMapTextAttribute = String.fromEnvironment(
    'open_street_map_text_atribute',
  );
}
