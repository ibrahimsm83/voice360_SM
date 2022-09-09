import 'dart:convert';

import 'package:collection/collection.dart';

class Email {
  String? email;
  String? label;

  Email({this.email, this.label});

  @override
  String toString() => 'Email(email: $email, label: $label)';

  factory Email.fromMap(Map<String, dynamic> data) => Email(
        email: data['email'] as String?,
        label: data['label'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'label': label,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Email].
  factory Email.fromJson(String data) {
    return Email.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Email] to a JSON string.
  String toJson() => json.encode(toMap());

  Email copyWith({
    String? email,
    String? label,
  }) {
    return Email(
      email: email ?? this.email,
      label: label ?? this.label,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Email) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => email.hashCode ^ label.hashCode;
}
