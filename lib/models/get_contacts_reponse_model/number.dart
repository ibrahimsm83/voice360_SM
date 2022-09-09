import 'dart:convert';

import 'package:collection/collection.dart';

class Number {
  int? contactId;
  String? number;
  String? label;

  Number({this.contactId, this.number, this.label});

  @override
  String toString() {
    return 'Number(contactId: $contactId, number: $number, label: $label)';
  }

  factory Number.fromMap(Map<String, dynamic> data) => Number(
        contactId: data['contact_id'] as int?,
        number: data['number'] as String?,
        label: data['label'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'contact_id': contactId,
        'number': number,
        'label': label,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Number].
  factory Number.fromJson(String data) {
    return Number.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Number] to a JSON string.
  String toJson() => json.encode(toMap());

  Number copyWith({
    int? contactId,
    String? number,
    String? label,
  }) {
    return Number(
      contactId: contactId ?? this.contactId,
      number: number ?? this.number,
      label: label ?? this.label,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Number) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => contactId.hashCode ^ number.hashCode ^ label.hashCode;
}
