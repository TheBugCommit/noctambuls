class AppDeepLinks {
  AppDeepLinks._();

  static const scheme = 'noctambuls';
  static const participantHost = 'participant';
  static const participantCodeParam = 'code';

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
}
