enum Environment {
  host(
    String.fromEnvironment(
      'HOST',
    ),
  );

  final String value;
  const Environment(this.value);
}
