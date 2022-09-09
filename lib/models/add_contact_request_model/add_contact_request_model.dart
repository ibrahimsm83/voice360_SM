import 'dart:convert';

import 'package:collection/collection.dart';

import 'email.dart';
import 'number.dart';

class AddContactRequestModel {
  String? name;
  List<Number>? numbers;
  String? number;
  String? labelNumber;
  List<Email>? emails;
  String? email;
  String? labelEmail;
  String? notes;

  AddContactRequestModel({
    this.name,
    this.numbers,
    this.number,
    this.labelNumber,
    this.emails,
    this.email,
    this.labelEmail,
    this.notes,
  });

  @override
  String toString() {
    return 'AddContactRequestModel(name: $name, numbers: $numbers, number: $number, labelNumber: $labelNumber, emails: $emails, email: $email, labelEmail: $labelEmail, notes: $notes)';
  }

  factory AddContactRequestModel.fromMap(Map<String, dynamic> data) {
    return AddContactRequestModel(
      name: data['name'] as String?,
      numbers: (data['numbers'] as List<dynamic>?)
          ?.map((e) => Number.fromMap(e as Map<String, dynamic>))
          .toList(),
      number: data['number'] as String?,
      labelNumber: data['labelNumber'] as String?,
      emails: (data['emails'] as List<dynamic>?)
          ?.map((e) => Email.fromMap(e as Map<String, dynamic>))
          .toList(),
      email: data['email'] as String?,
      labelEmail: data['labelEmail'] as String?,
      notes: data['notes'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'numbers': numbers?.map((e) => e.toMap()).toList(),
        'number': number,
        'labelNumber': labelNumber,
        'emails': emails?.map((e) => e.toMap()).toList(),
        'email': email,
        'labelEmail': labelEmail,
        'notes': notes,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddContactRequestModel].
  factory AddContactRequestModel.fromJson(String data) {
    return AddContactRequestModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AddContactRequestModel] to a JSON string.
  String toJson() => json.encode(toMap());

  AddContactRequestModel copyWith({
    String? name,
    List<Number>? numbers,
    String? number,
    String? labelNumber,
    List<Email>? emails,
    String? email,
    String? labelEmail,
    String? notes,
  }) {
    return AddContactRequestModel(
      name: name ?? this.name,
      numbers: numbers ?? this.numbers,
      number: number ?? this.number,
      labelNumber: labelNumber ?? this.labelNumber,
      emails: emails ?? this.emails,
      email: email ?? this.email,
      labelEmail: labelEmail ?? this.labelEmail,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AddContactRequestModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      name.hashCode ^
      numbers.hashCode ^
      number.hashCode ^
      labelNumber.hashCode ^
      emails.hashCode ^
      email.hashCode ^
      labelEmail.hashCode ^
      notes.hashCode;
}
