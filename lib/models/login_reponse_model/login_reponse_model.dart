import 'dart:convert';

import 'package:collection/collection.dart';

import 'app_user.dart';

class LoginReponseModel {
  AppUser? result;
  bool? errors;
  String? message;
  dynamic pageSize;

  LoginReponseModel({
    this.result,
    this.errors,
    this.message,
    this.pageSize,
  });

  @override
  String toString() {
    return 'LoginReponseModel(result: $result, errors: $errors, message: $message, pageSize: $pageSize)';
  }

  factory LoginReponseModel.fromMap(Map<String, dynamic> data) {
    return LoginReponseModel(
      result: data['result'] == null
          ? null
          : AppUser.fromMap(data['result'] as Map<String, dynamic>),
      errors: data['errors'] as bool?,
      message: data['message'] as String?,
      pageSize: data['page_size'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'result': result?.toMap(),
        'errors': errors,
        'message': message,
        'page_size': pageSize,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginReponseModel].
  factory LoginReponseModel.fromJson(String data) {
    return LoginReponseModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginReponseModel] to a JSON string.
  String toJson() => json.encode(toMap());

  LoginReponseModel copyWith({
    AppUser? result,
    bool? errors,
    String? message,
    dynamic pageSize,
  }) {
    return LoginReponseModel(
      result: result ?? this.result,
      errors: errors ?? this.errors,
      message: message ?? this.message,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LoginReponseModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      result.hashCode ^ errors.hashCode ^ message.hashCode ^ pageSize.hashCode;
}
