import 'dart:convert';

import 'package:collection/collection.dart';

class ContactListDataModel {
  String? name;
  int? pk;

  ContactListDataModel({this.name, this.pk});

  @override
  String toString() => 'ContactListDataModel(name: $name, pk: $pk)';

  factory ContactListDataModel.fromMap(Map<String, dynamic> data) {
    return ContactListDataModel(
      name: data['name'] as String?,
      pk: data['pk'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'pk': pk,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ContactListDataModel].
  factory ContactListDataModel.fromJson(String data) {
    return ContactListDataModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ContactListDataModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ContactListDataModel copyWith({
    String? name,
    int? pk,
  }) {
    return ContactListDataModel(
      name: name ?? this.name,
      pk: pk ?? this.pk,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ContactListDataModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => name.hashCode ^ pk.hashCode;
}
