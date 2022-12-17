import 'dart:convert';

import 'package:collection/collection.dart';

import 'account.dart';

class AppUser {
  dynamic phone;
  dynamic fax;
  String? firstname;
  dynamic title;
  bool? adminGroup;
  bool? billingGroup;
  int? zohoAccountId;
  int? zohoContactId;
  bool? technicalGroup;
  String? email;
  int? pk;
  dynamic mobile;
  String? profileImage;
  dynamic itpVoiceApiId;
  String? uiColorMode;
  dynamic itpVoiceUserId;
  String? lastname;
  Account? account;
  int? accountId;
  String? accessToken;
  String? refreshToken;
  String? timeZone;

  AppUser({
    this.phone,
    this.fax,
    this.firstname,
    this.title,
    this.adminGroup,
    this.billingGroup,
    this.zohoAccountId,
    this.zohoContactId,
    this.technicalGroup,
    this.email,
    this.pk,
    this.mobile,
    this.profileImage,
    this.itpVoiceApiId,
    this.uiColorMode,
    this.itpVoiceUserId,
    this.lastname,
    this.account,
    this.accountId,
    this.accessToken,
    this.refreshToken,
    this.timeZone,
  });

  @override
  String toString() {
    return 'Result(phone: $phone, fax: $fax, firstname: $firstname, title: $title, adminGroup: $adminGroup, billingGroup: $billingGroup, zohoAccountId: $zohoAccountId, zohoContactId: $zohoContactId, technicalGroup: $technicalGroup, email: $email, pk: $pk, mobile: $mobile, profileImage: $profileImage, itpVoiceApiId: $itpVoiceApiId, uiColorMode: $uiColorMode, itpVoiceUserId: $itpVoiceUserId, lastname: $lastname, account: $account, accountId: $accountId, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  factory AppUser.fromMap(Map<String, dynamic> data) => AppUser(
        phone: data['phone'] as dynamic,
        fax: data['fax'] as dynamic,
        firstname: data['firstname'] as String?,
        title: data['title'] as dynamic,
        adminGroup: data['admin_group'] as bool?,
        billingGroup: data['billing_group'] as bool?,
        zohoAccountId: data['zoho_account_id'] as int?,
        zohoContactId: data['zoho_contact_id'] as int?,
        technicalGroup: data['technical_group'] as bool?,
        email: data['email'] as String?,
        pk: data['pk'] as int?,
        mobile: data['mobile'] as dynamic,
        profileImage: data['profile_image'] as String?,
        itpVoiceApiId: data['itp_voice_api_id'] as dynamic,
        uiColorMode: data['ui_color_mode'] as String?,
        itpVoiceUserId: data['itp_voice_user_id'] as dynamic,
        lastname: data['lastname'] as String?,
        account: data['account'] == null ? null : Account.fromMap(data['account'] as Map<String, dynamic>),
        accountId: data['account_id'] as int?,
        accessToken: data['access_token'] as String?,
        refreshToken: data['refresh_token'] as String?,
        timeZone: data['time_zone'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'phone': phone,
        'fax': fax,
        'firstname': firstname,
        'title': title,
        'admin_group': adminGroup,
        'billing_group': billingGroup,
        'zoho_account_id': zohoAccountId,
        'zoho_contact_id': zohoContactId,
        'technical_group': technicalGroup,
        'email': email,
        'pk': pk,
        'mobile': mobile,
        'profile_image': profileImage,
        'itp_voice_api_id': itpVoiceApiId,
        'ui_color_mode': uiColorMode,
        'itp_voice_user_id': itpVoiceUserId,
        'lastname': lastname,
        'account': account?.toMap(),
        'account_id': accountId,
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'time_zone': timeZone
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Result].
  factory AppUser.fromJson(String data) {
    return AppUser.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Result] to a JSON string.
  String toJson() => json.encode(toMap());

  AppUser copyWith({
    dynamic phone,
    dynamic fax,
    String? firstname,
    dynamic title,
    bool? adminGroup,
    bool? billingGroup,
    int? zohoAccountId,
    int? zohoContactId,
    bool? technicalGroup,
    String? email,
    int? pk,
    dynamic mobile,
    String? profileImage,
    dynamic itpVoiceApiId,
    String? uiColorMode,
    dynamic itpVoiceUserId,
    String? lastname,
    Account? account,
    int? accountId,
    String? accessToken,
    String? refreshToken,
  }) {
    return AppUser(
      phone: phone ?? this.phone,
      fax: fax ?? this.fax,
      firstname: firstname ?? this.firstname,
      title: title ?? this.title,
      adminGroup: adminGroup ?? this.adminGroup,
      billingGroup: billingGroup ?? this.billingGroup,
      zohoAccountId: zohoAccountId ?? this.zohoAccountId,
      zohoContactId: zohoContactId ?? this.zohoContactId,
      technicalGroup: technicalGroup ?? this.technicalGroup,
      email: email ?? this.email,
      pk: pk ?? this.pk,
      mobile: mobile ?? this.mobile,
      profileImage: profileImage ?? this.profileImage,
      itpVoiceApiId: itpVoiceApiId ?? this.itpVoiceApiId,
      uiColorMode: uiColorMode ?? this.uiColorMode,
      itpVoiceUserId: itpVoiceUserId ?? this.itpVoiceUserId,
      lastname: lastname ?? this.lastname,
      account: account ?? this.account,
      accountId: accountId ?? this.accountId,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AppUser) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      phone.hashCode ^
      fax.hashCode ^
      firstname.hashCode ^
      title.hashCode ^
      adminGroup.hashCode ^
      billingGroup.hashCode ^
      zohoAccountId.hashCode ^
      zohoContactId.hashCode ^
      technicalGroup.hashCode ^
      email.hashCode ^
      pk.hashCode ^
      mobile.hashCode ^
      profileImage.hashCode ^
      itpVoiceApiId.hashCode ^
      uiColorMode.hashCode ^
      itpVoiceUserId.hashCode ^
      lastname.hashCode ^
      account.hashCode ^
      accountId.hashCode ^
      accessToken.hashCode ^
      refreshToken.hashCode;
}
