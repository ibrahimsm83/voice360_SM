import 'dart:convert';

import 'package:collection/collection.dart';

import 'service.dart';

class ServicesResponseModel {
  List<Services>? services;
  bool? errors;
  String? message;
  dynamic pageSize;

  ServicesResponseModel({
    this.services,
    this.errors,
    this.message,
    this.pageSize,
  });

  @override
  String toString() {
    return 'ServicesResponseModel(result: $services, errors: $errors, message: $message, pageSize: $pageSize)';
  }

  factory ServicesResponseModel.fromMap(Map<String, dynamic> data) {
    return ServicesResponseModel(
      services: (data['result'] as List<dynamic>?)
          ?.map((e) => Services.fromMap(e as Map<String, dynamic>))
          .toList(),
      errors: data['errors'] as bool?,
      message: data['message'] as String?,
      pageSize: data['page_size'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'result': services?.map((e) => e.toMap()).toList(),
        'errors': errors,
        'message': message,
        'page_size': pageSize,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ServicesResponseModel].
  factory ServicesResponseModel.fromJson(String data) {
    return ServicesResponseModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ServicesResponseModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ServicesResponseModel copyWith({
    List<Services>? result,
    bool? errors,
    String? message,
    dynamic pageSize,
  }) {
    return ServicesResponseModel(
      services: result ?? this.services,
      errors: errors ?? this.errors,
      message: message ?? this.message,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ServicesResponseModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      services.hashCode ^
      errors.hashCode ^
      message.hashCode ^
      pageSize.hashCode;
}
