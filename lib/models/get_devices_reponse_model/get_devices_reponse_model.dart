import 'dart:convert';

import 'package:collection/collection.dart';

import 'devices.dart';

class GetDevicesReponseModel {
  List<Devices>? devices;
  bool? errors;
  dynamic error;
  String? message;
  dynamic pageSize;
  dynamic nextStartKey;
  dynamic startKey;

  GetDevicesReponseModel({
    this.devices,
    this.errors,
    this.error,
    this.message,
    this.pageSize,
    this.nextStartKey,
    this.startKey,
  });

  @override
  String toString() {
    return 'GetDevicesReponseModel(result: $devices, errors: $errors, error: $error, message: $message, pageSize: $pageSize, nextStartKey: $nextStartKey, startKey: $startKey)';
  }

  factory GetDevicesReponseModel.fromMap(Map<String, dynamic> data) {
    return GetDevicesReponseModel(
      devices: (data['result'] as List<dynamic>?)
          ?.map((e) => Devices.fromMap(e as Map<String, dynamic>))
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
        'result': devices?.map((e) => e.toMap()).toList(),
        'errors': errors,
        'error': error,
        'message': message,
        'page_size': pageSize,
        'next_start_key': nextStartKey,
        'start_key': startKey,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetDevicesReponseModel].
  factory GetDevicesReponseModel.fromJson(String data) {
    return GetDevicesReponseModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GetDevicesReponseModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GetDevicesReponseModel copyWith({
    List<Devices>? result,
    bool? errors,
    dynamic error,
    String? message,
    dynamic pageSize,
    dynamic nextStartKey,
    dynamic startKey,
  }) {
    return GetDevicesReponseModel(
      devices: result ?? this.devices,
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
    if (other is! GetDevicesReponseModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      devices.hashCode ^
      errors.hashCode ^
      error.hashCode ^
      message.hashCode ^
      pageSize.hashCode ^
      nextStartKey.hashCode ^
      startKey.hashCode;
}
