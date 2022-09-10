import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:itp_voice/models/get_contacts_reponse_model/user_contact.dart';

import 'result.dart';

class GetContactsReponseModel {
  List<UserContact>? contacts;
  bool? errors;
  dynamic error;
  String? message;
  dynamic pageSize;
  dynamic nextStartKey;
  dynamic startKey;

  GetContactsReponseModel({
    this.contacts,
    this.errors,
    this.error,
    this.message,
    this.pageSize,
    this.nextStartKey,
    this.startKey,
  });

  @override
  String toString() {
    return 'GetContactsReponseModel(result: $contacts, errors: $errors, error: $error, message: $message, pageSize: $pageSize, nextStartKey: $nextStartKey, startKey: $startKey)';
  }

  factory GetContactsReponseModel.fromMap(Map<String, dynamic> data) {
    return GetContactsReponseModel(
      contacts: data['result'] == null
          ? null
          : (data['result'] as List<dynamic>)
              .map((e) => UserContact.fromMap(e))
              .toList(), //ContactsData.fromMap(data['result'] as Map<String, dynamic>),
      errors: data['errors'] as bool?,
      error: data['error'] as dynamic,
      message: data['message'] as String?,
      pageSize: data['page_size'] as dynamic,
      nextStartKey: data['next_start_key'] as dynamic,
      startKey: data['start_key'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'result': contacts?..map((e) => e.toMap()).toList(),
        'errors': errors,
        'error': error,
        'message': message,
        'page_size': pageSize,
        'next_start_key': nextStartKey,
        'start_key': startKey,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetContactsReponseModel].
  factory GetContactsReponseModel.fromJson(String data) {
    return GetContactsReponseModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GetContactsReponseModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GetContactsReponseModel copyWith({
    List<UserContact>? result,
    bool? errors,
    dynamic error,
    String? message,
    dynamic pageSize,
    dynamic nextStartKey,
    dynamic startKey,
  }) {
    return GetContactsReponseModel(
      contacts: result ?? this.contacts,
      errors: errors ?? this.errors,
      error: error ?? this.error,
      message: message ?? this.message,
      pageSize: pageSize ?? this.pageSize,
      nextStartKey: nextStartKey ?? this.nextStartKey,
      startKey: startKey ?? this.startKey,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GetContactsReponseModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      contacts.hashCode ^
      errors.hashCode ^
      error.hashCode ^
      message.hashCode ^
      pageSize.hashCode ^
      nextStartKey.hashCode ^
      startKey.hashCode;
}
