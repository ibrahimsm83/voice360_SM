import 'dart:convert';

import 'package:collection/collection.dart';

class Devices {
  int? ownerId;
  int? accountId;
  int? pk;
  String? sipPassword;
  String? deviceType;
  String? sipUsername;

  Devices({
    this.ownerId,
    this.accountId,
    this.pk,
    this.sipPassword,
    this.deviceType,
    this.sipUsername,
  });

  @override
  String toString() {
    return 'Devices(ownerId: $ownerId, accountId: $accountId, pk: $pk, sipPassword: $sipPassword, deviceType: $deviceType, sipUsername: $sipUsername)';
  }

  factory Devices.fromMap(Map<String, dynamic> data) => Devices(
        ownerId: data['owner_id'] as int?,
        accountId: data['account_id'] as int?,
        pk: data['pk'] as int?,
        sipPassword: data['sip_password'] as String?,
        deviceType: data['device_type'] as String?,
        sipUsername: data['sip_username'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'owner_id': ownerId,
        'account_id': accountId,
        'pk': pk,
        'sip_password': sipPassword,
        'device_type': deviceType,
        'sip_username': sipUsername,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Devices].
  factory Devices.fromJson(String data) {
    return Devices.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Devices] to a JSON string.
  String toJson() => json.encode(toMap());

  Devices copyWith({
    int? ownerId,
    int? accountId,
    int? pk,
    String? sipPassword,
    String? deviceType,
    String? sipUsername,
  }) {
    return Devices(
      ownerId: ownerId ?? this.ownerId,
      accountId: accountId ?? this.accountId,
      pk: pk ?? this.pk,
      sipPassword: sipPassword ?? this.sipPassword,
      deviceType: deviceType ?? this.deviceType,
      sipUsername: sipUsername ?? this.sipUsername,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Devices) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      ownerId.hashCode ^
      accountId.hashCode ^
      pk.hashCode ^
      sipPassword.hashCode ^
      deviceType.hashCode ^
      sipUsername.hashCode;
}
