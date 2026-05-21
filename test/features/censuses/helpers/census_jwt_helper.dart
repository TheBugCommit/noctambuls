import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

// Parella de claus RSA de test generada únicament per als tests de JoinCensusUseCase.
// La clau pública corresponent s'ha injectat a env_config.g.dart (censusJwtPublicKey).
// Per restaurar la clau de producció: fvm flutter pub run build_runner build

const _testPrivateKeyPem =
    '-----BEGIN PRIVATE KEY-----\n'
    'MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC+yzUyVn1+fk9D\n'
    'UsLULboYIHOGkabGBYDaZ6a4TFSlI3v5Od6NsG4TUtHHMIyw8yz171vler6KwncH\n'
    'iqBRXerwAIj0goKd3CaQsdpqC34HM3WlKc/G+zZf1hz2U0vBy6lv2FogBb680sjR\n'
    'pQ+BxQk653ik+loXtBrpI9E+GnQYxsxws7x/Ao5iNU5mFLN5OipLLUkR2Rf17M/6\n'
    'kVJq6FkAy79LX4nQchp7IS7ezFT0xetkPdCHxg0T6skOZA528KySlNMY9x8XaQ4+\n'
    'sQ9pLLs6Rmc5/D7gWEnB6oDOyPf4MqTyoFw4k9/iaND5b3dUPTkm355VKms1Qlfl\n'
    'wRI6/clhAgMBAAECggEAAgZi+VabyL03UwUIiHMXCtki0sB+XTMLIN5JYaK9Qf6u\n'
    'OtkdcqJnC61VCMS8FIdzMGXGw1jt92fslpvW+2AYXY1a5sHxGBLxZZcepOIb94B5\n'
    'QNxQjkmFpGcfyfE8wEj8opFQtQ7sjSFdVGTIpSlhwYJaCGG4FbDxmWx59LtYBLiI\n'
    'NAFMJyK3tE+JDezh0pcWB7KovyyUs+3cad7smWGNGLJ10FraoaAuq8+bwUWot/XC\n'
    '+cfMzCUPL/eARjtrWCF2RREMJ8IgOwFrreocgsHHGnnfWRaTMHRdChFZKabF9J8x\n'
    'OnuVJtY8OWdzY6KEJcvSa4ZKCbkIVGoZTMBXJOoFgQKBgQD22RrjnVNa8WC7kmCu\n'
    'NvnT3c9fiazSsfEQTZJ0+DkTKjbmY9eXl8jyzklib2z0tOk13JR08v+EbkGVVwDd\n'
    'ZeWzpFFl75aIlYoy21Np3NjJGo7CKYZhwXvNYtlCWDe2qFRibEB4zy+LWHNjB0ta\n'
    '9z2t0ozZmxUCv/48mOIbj5EzwQKBgQDF3hPyap9pKk6boOm7tJwTPv4Cntko/cE9\n'
    'tzj7SRYDJztie/QQr0lgW2DrAQNST9VfLy7E7pvbJi2cP35mKXlsWV0J/5HFuuKh\n'
    'Y6xAlzGzI++PjEpsjmIcwBbXRZ4e0rlB1uKuAWQfrDzcWgLh74+xepG6QZFxljWm\n'
    'o2zuKCd9oQKBgQDBanWmOYSxsoZAEr7MYuk3+Anf6wlOgfzH8HA8VK6r9JzVww+P\n'
    'iW/7yGU5yuMNjp9ZA8ATLr/FbXrX4DceQxRLwQnCnItP9BQ4KyBdx5zZXoTTYCQa\n'
    'frdZxAVF9ceZyKVuBTIzNuwi/ChVRMbnvOhIRbz1WI2K/RLhOk2YmNKGQQKBgCFJ\n'
    'T8+7MiAN9vVlZ4ylQJBYS4EDWgL0VVrdhN95FxPmuK3DrnZUFqL4HGDMZdOmDH4b\n'
    'wOFuRpfiX0/muovTNFMO4YD6FnrOCqwdyW+AP+MkC3v5nNeQSF8PzYffdU84IeQ6\n'
    'kx20rDRL1F05YzzBAUpZFUThHOef3lyvJ3cVGDehAoGBANJRf4qOfVZs+/KEQb6c\n'
    'j1u79Zo09dXwpWixFqNOGuCj81lCClfMm4t93/OLhJDExj+SQK+rcjMzLTTdctWJ\n'
    'ETUsloWIOkvUt0hpB18MeVIRxTglv8lqAAqZRoMj/+uz4wQ1NTfVDICU5Fusa24S\n'
    'je+LsJ+BGDIRiiXBeIn3itGn\n'
    '-----END PRIVATE KEY-----';

String makeCensusJwt({
  required String censusId,
  required String title,
  required String startTime,
}) {
  final jwt = JWT({'i': censusId, 't': title, 's': startTime});
  return jwt.sign(RSAPrivateKey(_testPrivateKeyPem), algorithm: JWTAlgorithm.RS256);
}
