import 'dart:convert';

import 'package:collection/collection.dart';

class Profile {
  bool? adminGroup;
  String? firstname;
  int? pk;
  dynamic mobile;
  bool? technicalGroup;
  bool? billingGroup;
  dynamic account;
  String? email;
  String? uiColorMode;
  String? timeZone;
  int? accountId;
  String? lastname;

  Profile({
    this.adminGroup,
    this.firstname,
    this.pk,
    this.mobile,
    this.technicalGroup,
    this.billingGroup,
    this.account,
    this.email,
    this.uiColorMode,
    this.timeZone,
    this.accountId,
    this.lastname,
  });

  @override
  String toString() {
    return 'Result(adminGroup: $adminGroup, firstname: $firstname, pk: $pk, mobile: $mobile, technicalGroup: $technicalGroup, billingGroup: $billingGroup, account: $account, email: $email, uiColorMode: $uiColorMode, timeZone: $timeZone, accountId: $accountId, lastname: $lastname)';
  }

  factory Profile.fromMap(Map<String, dynamic> data) => Profile(
        adminGroup: data['admin_group'] as bool?,
        firstname: data['firstname'] as String?,
        pk: data['pk'] as int?,
        mobile: data['mobile'] as dynamic,
        technicalGroup: data['technical_group'] as bool?,
        billingGroup: data['billing_group'] as bool?,
        account: data['account'] as dynamic,
        email: data['email'] as String?,
        uiColorMode: data['ui_color_mode'] as String?,
        timeZone: data['time_zone'] as String?,
        accountId: data['account_id'] as int?,
        lastname: data['lastname'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'admin_group': adminGroup,
        'firstname': firstname,
        'pk': pk,
        'mobile': mobile,
        'technical_group': technicalGroup,
        'billing_group': billingGroup,
        'account': account,
        'email': email,
        'ui_color_mode': uiColorMode,
        'time_zone': timeZone,
        'account_id': accountId,
        'lastname': lastname,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Result].
  factory Profile.fromJson(String data) {
    return Profile.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Result] to a JSON string.
  String toJson() => json.encode(toMap());

  Profile copyWith({
    bool? adminGroup,
    String? firstname,
    int? pk,
    dynamic mobile,
    bool? technicalGroup,
    bool? billingGroup,
    dynamic account,
    String? email,
    String? uiColorMode,
    String? timeZone,
    int? accountId,
    String? lastname,
  }) {
    return Profile(
      adminGroup: adminGroup ?? this.adminGroup,
      firstname: firstname ?? this.firstname,
      pk: pk ?? this.pk,
      mobile: mobile ?? this.mobile,
      technicalGroup: technicalGroup ?? this.technicalGroup,
      billingGroup: billingGroup ?? this.billingGroup,
      account: account ?? this.account,
      email: email ?? this.email,
      uiColorMode: uiColorMode ?? this.uiColorMode,
      timeZone: timeZone ?? this.timeZone,
      accountId: accountId ?? this.accountId,
      lastname: lastname ?? this.lastname,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Profile) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      adminGroup.hashCode ^
      firstname.hashCode ^
      pk.hashCode ^
      mobile.hashCode ^
      technicalGroup.hashCode ^
      billingGroup.hashCode ^
      account.hashCode ^
      email.hashCode ^
      uiColorMode.hashCode ^
      timeZone.hashCode ^
      accountId.hashCode ^
      lastname.hashCode;
}
