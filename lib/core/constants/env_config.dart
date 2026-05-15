import 'package:envied/envied.dart';

part 'env_config.g.dart';

@Envied(path: 'env/.env')
abstract class EnvConfig {
  @EnviedField(varName: 'ENV')
  static const String env = _EnvConfig.env;

  @EnviedField(varName: 'SERVER_URL')
  static const String serverUrl = _EnvConfig.serverUrl;

  @EnviedField(varName: 'GOOGLE_WEB_CLIENT_ID', obfuscate: true)
  static final String googleWebClientId = _EnvConfig.googleWebClientId;

  @EnviedField(varName: 'SERVER_API_KEY', obfuscate: true)
  static final String serverApiKey = _EnvConfig.serverApiKey;

  @EnviedField(varName: 'TERMS_URL')
  static const String termsAndConditionsUrl = _EnvConfig.termsAndConditionsUrl;

  @EnviedField(varName: 'PRIVACY_URL')
  static const String privacyUrl = _EnvConfig.privacyUrl;

  @EnviedField(varName: 'ABOUT_URL')
  static const String aboutUrl = _EnvConfig.aboutUrl;

  @EnviedField(varName: 'HELP_URL')
  static const String helpUrl = _EnvConfig.helpUrl;

  @EnviedField(varName: 'PACKAGE_NAME')
  static const String packageName = _EnvConfig.packageName;

  @EnviedField(varName: 'OPEN_STREET_MAP_COPYRIGHT')
  static const String openStreetMapCopyright =
      _EnvConfig.openStreetMapCopyright;

  @EnviedField(varName: 'OPEN_TOPO_MAP_ABOUT')
  static const String openTopoMapAbout = _EnvConfig.openTopoMapAbout;

  @EnviedField(varName: 'OPEN_STREET_MAP_TILES')
  static const String openStreetMapTiles = _EnvConfig.openStreetMapTiles;

  @EnviedField(varName: 'OPEN_TOPO_MAP_TILES')
  static const String openTopoMapTiles = _EnvConfig.openTopoMapTiles;

  @EnviedField(varName: 'OPEN_TOPO_MAP_TEXT_ATTRIBUTE')
  static const String openTopoMapTextAttribute =
      _EnvConfig.openTopoMapTextAttribute;

  @EnviedField(varName: 'OPEN_TOPO_MAP_STYLE_ATTRIBUTE')
  static const String openTopoMapStyleAttribute =
      _EnvConfig.openTopoMapStyleAttribute;

  @EnviedField(varName: 'OPEN_STREET_MAP_TEXT_ATRIBUTE')
  static const String openStreetMapTextAttribute =
      _EnvConfig.openStreetMapTextAttribute;

  @EnviedField(varName: 'CENSUS_JWT_PUBLIC_KEY')
  static const String censusJwtPublicKey = _EnvConfig.censusJwtPublicKey;
}
