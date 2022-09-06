import 'dart:convert';

class IBusinessException {
  final String message;
  final StackTrace? stackTrace;

  const IBusinessException(this.message, [this.stackTrace]);

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  factory IBusinessException.fromMap(Map<String, dynamic> map) {
    return IBusinessException(
      map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory IBusinessException.fromJson(String source) =>
      IBusinessException.fromMap(json.decode(source));
}

class UniqueValuesException extends IBusinessException {
  UniqueValuesException(String message) : super(message);
}
