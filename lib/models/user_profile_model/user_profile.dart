import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class UserProfile {
  Profile? profile;
  bool? errors;
  String? message;
  dynamic pageSize;

  UserProfile({this.profile, this.errors, this.message, this.pageSize});

  @override
  String toString() {
    return 'UserProfile(result: $profile, errors: $errors, message: $message, pageSize: $pageSize)';
  }

  factory UserProfile.fromMap(Map<String, dynamic> data) => UserProfile(
        profile: data['result'] == null
            ? null
            : Profile.fromMap(data['result'] as Map<String, dynamic>),
        errors: data['errors'] as bool?,
        message: data['message'] as String?,
        pageSize: data['page_size'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'result': profile?.toMap(),
        'errors': errors,
        'message': message,
        'page_size': pageSize,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserProfile].
  factory UserProfile.fromJson(String data) {
    return UserProfile.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserProfile] to a JSON string.
  String toJson() => json.encode(toMap());

  UserProfile copyWith({
    Profile? result,
    bool? errors,
    String? message,
    dynamic pageSize,
  }) {
    return UserProfile(
      profile: result ?? this.profile,
      errors: errors ?? this.errors,
      message: message ?? this.message,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserProfile) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      profile.hashCode ^ errors.hashCode ^ message.hashCode ^ pageSize.hashCode;
}
