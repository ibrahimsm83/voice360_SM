import 'dart:convert';

import 'package:collection/collection.dart';

import 'user_contact.dart';

class ModelList {
  List<UserContact>? userContacts;
  List<dynamic>? defaultContacts;

  ModelList({this.userContacts, this.defaultContacts});

  @override
  String toString() {
    return 'ModelList(userContacts: $userContacts, defaultContacts: $defaultContacts)';
  }

  factory ModelList.fromMap(Map<String, dynamic> data) => ModelList(
        userContacts: (data['user_contacts'] as List<dynamic>?)
            ?.map((e) => UserContact.fromMap(e as Map<String, dynamic>))
            .toList(),
        defaultContacts: data['default_contacts'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'user_contacts': userContacts?.map((e) => e.toMap()).toList(),
        'default_contacts': defaultContacts,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ModelList].
  factory ModelList.fromJson(String data) {
    return ModelList.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ModelList] to a JSON string.
  String toJson() => json.encode(toMap());

  ModelList copyWith({
    List<UserContact>? userContacts,
    List<dynamic>? defaultContacts,
  }) {
    return ModelList(
      userContacts: userContacts ?? this.userContacts,
      defaultContacts: defaultContacts ?? this.defaultContacts,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ModelList) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => userContacts.hashCode ^ defaultContacts.hashCode;
}
