enum AuthProviderType {
  google('google'),
  apple('apple'),
  email('email')
  ;

  const AuthProviderType(this.value);

  final String value;
}
