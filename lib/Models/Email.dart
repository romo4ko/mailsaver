import 'package:flutter/foundation.dart' show immutable;

@immutable
class Email {
  final int id;
  final String value;
  final int? categoryId;
  final String createdAt;

  const Email({
    required this.id,
    required this.value,
    required this.categoryId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "value": value,
      "categoryId": categoryId,
      "createdAt": createdAt,
    };
  }
}