import 'dart:convert';

import 'package:collection/collection.dart';

import 'number.dart';

class UserContact {
  int? pk;
  String? notes;
  String? email;
  int? userId;
  dynamic externalNumber;
  String? name;
  dynamic internalNumber;
  String? accountId;
  List<Number>? numbers;
  List<dynamic>? emails;

  UserContact({
    this.pk,
    this.notes,
    this.email,
    this.userId,
    this.externalNumber,
    this.name,
    this.internalNumber,
    this.accountId,
    this.numbers,
    this.emails,
  });

  @override
  String toString() {
    return 'UserContact(pk: $pk, notes: $notes, email: $email, userId: $userId, externalNumber: $externalNumber, name: $name, internalNumber: $internalNumber, accountId: $accountId, numbers: $numbers, emails: $emails)';
  }

  factory UserContact.fromMap(Map<String, dynamic> data) => UserContact(
        pk: data['pk'] as int?,
        notes: data['notes'] as String?,
        email: data['email'] as String?,
        userId: data['user_id'] as int?,
        externalNumber: data['external_number'] as dynamic,
        name: data['name'] as String?,
        internalNumber: data['internal_number'] as dynamic,
        accountId: data['account_id'] as String?,
        numbers: (data['numbers'] as List<dynamic>?)
            ?.map((e) => Number.fromMap(e as Map<String, dynamic>))
            .toList(),
        emails: data['emails'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'pk': pk,
        'notes': notes,
        'email': email,
        'user_id': userId,
        'external_number': externalNumber,
        'name': name,
        'internal_number': internalNumber,
        'account_id': accountId,
        'numbers': numbers?.map((e) => e.toMap()).toList(),
        'emails': emails,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserContact].
  factory UserContact.fromJson(String data) {
    return UserContact.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserContact] to a JSON string.
  String toJson() => json.encode(toMap());

  UserContact copyWith({
    int? pk,
    String? notes,
    String? email,
    int? userId,
    dynamic externalNumber,
    String? name,
    dynamic internalNumber,
    String? accountId,
    List<Number>? numbers,
    List<dynamic>? emails,
  }) {
    return UserContact(
      pk: pk ?? this.pk,
      notes: notes ?? this.notes,
      email: email ?? this.email,
      userId: userId ?? this.userId,
      externalNumber: externalNumber ?? this.externalNumber,
      name: name ?? this.name,
      internalNumber: internalNumber ?? this.internalNumber,
      accountId: accountId ?? this.accountId,
      numbers: numbers ?? this.numbers,
      emails: emails ?? this.emails,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserContact) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      pk.hashCode ^
      notes.hashCode ^
      email.hashCode ^
      userId.hashCode ^
      externalNumber.hashCode ^
      name.hashCode ^
      internalNumber.hashCode ^
      accountId.hashCode ^
      numbers.hashCode ^
      emails.hashCode;
}
