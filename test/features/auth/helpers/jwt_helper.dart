import 'dart:convert';

String makeJwt({
  required String id,
  required String email,
  required int exp,
}) {
  final header = base64Url.encode(utf8.encode('{"alg":"HS256","typ":"JWT"}'));
  final payload = base64Url.encode(
    utf8.encode(jsonEncode({'id': id, 'username': email, 'exp': exp})),
  );
  return '$header.$payload.fakesig';
}

final int futureExp = DateTime(2099).millisecondsSinceEpoch ~/ 1000;
final int pastExp = DateTime(2020).millisecondsSinceEpoch ~/ 1000;
