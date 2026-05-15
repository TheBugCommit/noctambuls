class AppDeepLinks {
  AppDeepLinks._();

  static const scheme = 'noctambuls';
  static const participantHost = 'participant';
  static const participantCodeParam = 'code';

  static const censusHost = 'app.associaciotaxus.cat';
  static const censusPath = '/census/join';
  static const censusTokenParam = 'token';

  static bool isValidDeepLink(Uri uri) {
    return uri.scheme == scheme && uri.host == participantHost;
  }

  static String? extractParticipantCode(Uri uri) {
    return uri.queryParameters[participantCodeParam];
  }

  static String buildParticipantUri(String code) {
    final uri = Uri(
      scheme: scheme,
      host: participantHost,
      queryParameters: {
        participantCodeParam: code,
      },
    );

    return uri.toString();
  }

  static bool isCensusDeepLink(Uri uri) {
    return (uri.scheme == 'https' || uri.scheme == 'http') &&
        uri.host == censusHost &&
        uri.path == censusPath &&
        uri.queryParameters.containsKey(censusTokenParam);
  }

  static String? extractCensusToken(Uri uri) {
    return uri.queryParameters[censusTokenParam];
  }
}
