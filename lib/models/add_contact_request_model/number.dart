import 'dart:convert';

import 'package:collection/collection.dart';

class Number {
  String? number;
  String? label;

  Number({this.number, this.label});

  @override
  String toString() => 'Number(number: $number, label: $label)';

  factory Number.fromMap(Map<String, dynamic> data) => Number(
        number: data['number'] as String?,
        label: data['label'] as String?,
      );

  Map<String, dynamic> toMap() => {
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
    String? number,
    String? label,
  }) {
    return Number(
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
  int get hashCode => number.hashCode ^ label.hashCode;
}
