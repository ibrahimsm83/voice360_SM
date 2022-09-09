import 'dart:convert';

import 'package:collection/collection.dart';

import 'model_list.dart';

class ContactsData {
  ModelList? modelList;
  int? totalPages;
  int? page;

  ContactsData({this.modelList, this.totalPages, this.page});

  @override
  String toString() {
    return 'Result(modelList: $modelList, totalPages: $totalPages, page: $page)';
  }

  factory ContactsData.fromMap(Map<String, dynamic> data) => ContactsData(
        modelList: data['model_list'] == null
            ? null
            : ModelList.fromMap(data['model_list'] as Map<String, dynamic>),
        totalPages: data['total_pages'] as int?,
        page: data['page'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'model_list': modelList?.toMap(),
        'total_pages': totalPages,
        'page': page,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Result].
  factory ContactsData.fromJson(String data) {
    return ContactsData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Result] to a JSON string.
  String toJson() => json.encode(toMap());

  ContactsData copyWith({
    ModelList? modelList,
    int? totalPages,
    int? page,
  }) {
    return ContactsData(
      modelList: modelList ?? this.modelList,
      totalPages: totalPages ?? this.totalPages,
      page: page ?? this.page,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ContactsData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => modelList.hashCode ^ totalPages.hashCode ^ page.hashCode;
}
