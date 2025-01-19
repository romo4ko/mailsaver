import 'package:flutter/foundation.dart' show immutable;

@immutable
class Email {
  final int? id;
  final String value;
  final int? categoryId;
  final DateTime? createdAt;

  const Email({
    this.id,
    required this.value,
    this.categoryId,
    this.createdAt,
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