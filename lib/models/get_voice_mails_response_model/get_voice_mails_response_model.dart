import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class GetVoiceMailsResponseModel {
  List<VoiceMails>? voiceMails;
  bool? errors;
  dynamic error;
  String? message;
  dynamic pageSize;
  dynamic nextStartKey;
  dynamic startKey;

  GetVoiceMailsResponseModel({
    this.voiceMails,
    this.errors,
    this.error,
    this.message,
    this.pageSize,
    this.nextStartKey,
    this.startKey,
  });

  @override
  String toString() {
    return 'GetVoiceMailsResponseModel(result: $voiceMails, errors: $errors, error: $error, message: $message, pageSize: $pageSize, nextStartKey: $nextStartKey, startKey: $startKey)';
  }

  factory GetVoiceMailsResponseModel.fromMap(Map<String, dynamic> data) {
    return GetVoiceMailsResponseModel(
      voiceMails: (data['result'] as List<dynamic>?)
          ?.map((e) => VoiceMails.fromMap(e as Map<String, dynamic>))
          .toList(),
      errors: data['errors'] as bool?,
      error: data['error'] as dynamic,
      message: data['message'] as String?,
      pageSize: data['page_size'] as dynamic,
      nextStartKey: data['next_start_key'] as dynamic,
      startKey: data['start_key'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'result': voiceMails?.map((e) => e.toMap()).toList(),
        'errors': errors,
        'error': error,
        'message': message,
        'page_size': pageSize,
        'next_start_key': nextStartKey,
        'start_key': startKey,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetVoiceMailsResponseModel].
  factory GetVoiceMailsResponseModel.fromJson(String data) {
    return GetVoiceMailsResponseModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GetVoiceMailsResponseModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GetVoiceMailsResponseModel copyWith({
    List<VoiceMails>? result,
    bool? errors,
    dynamic error,
    String? message,
    dynamic pageSize,
    dynamic nextStartKey,
    dynamic startKey,
  }) {
    return GetVoiceMailsResponseModel(
      voiceMails: result ?? this.voiceMails,
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
    if (other is! GetVoiceMailsResponseModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      voiceMails.hashCode ^
      errors.hashCode ^
      error.hashCode ^
      message.hashCode ^
      pageSize.hashCode ^
      nextStartKey.hashCode ^
      startKey.hashCode;
}
