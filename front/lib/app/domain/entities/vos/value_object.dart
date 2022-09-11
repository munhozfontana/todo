abstract class ValueObject {
  String? validator(String? inputValue);
  void onChange(String changeValue);
}
