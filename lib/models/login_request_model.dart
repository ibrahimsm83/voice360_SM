import 'dart:convert';

import 'package:collection/collection.dart';

class LoginRequestModel {
  String? username;
  String? password;

  LoginRequestModel({this.username, this.password});

  @override
  String toString() {
    return 'LoginRequestModel(username: $username, password: $password)';
  }

  factory LoginRequestModel.fromMap(Map<String, dynamic> data) {
    return LoginRequestModel(
      username: data['username'] as String?,
      password: data['password'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'username': username,
        'password': password,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginRequestModel].
  factory LoginRequestModel.fromJson(String data) {
    return LoginRequestModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginRequestModel] to a JSON string.
  String toJson() => json.encode(toMap());

  LoginRequestModel copyWith({
    String? username,
    String? password,
  }) {
    return LoginRequestModel(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LoginRequestModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
