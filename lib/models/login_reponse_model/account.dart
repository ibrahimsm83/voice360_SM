import 'dart:convert';

import 'package:collection/collection.dart';

class Account {
  String? name;
  int? agentId;
  dynamic crmLoginUserId;
  String? industry;
  dynamic imgurl;
  String? billingCity;
  String? agent;
  String? billingAddressSuite;
  String? accountType;
  String? phone;
  String? billingState;
  String? billingApiId;
  String? billingAddress;
  int? zohoAccountId;
  int? pk;
  String? billingZipcode;
  String? accountnumber;
  dynamic parentAccountId;
  String? website;
  String? billingCountry;

  Account({
    this.name,
    this.agentId,
    this.crmLoginUserId,
    this.industry,
    this.imgurl,
    this.billingCity,
    this.agent,
    this.billingAddressSuite,
    this.accountType,
    this.phone,
    this.billingState,
    this.billingApiId,
    this.billingAddress,
    this.zohoAccountId,
    this.pk,
    this.billingZipcode,
    this.accountnumber,
    this.parentAccountId,
    this.website,
    this.billingCountry,
  });

  @override
  String toString() {
    return 'Account(name: $name, agentId: $agentId, crmLoginUserId: $crmLoginUserId, industry: $industry, imgurl: $imgurl, billingCity: $billingCity, agent: $agent, billingAddressSuite: $billingAddressSuite, accountType: $accountType, phone: $phone, billingState: $billingState, billingApiId: $billingApiId, billingAddress: $billingAddress, zohoAccountId: $zohoAccountId, pk: $pk, billingZipcode: $billingZipcode, accountnumber: $accountnumber, parentAccountId: $parentAccountId, website: $website, billingCountry: $billingCountry)';
  }

  factory Account.fromMap(Map<String, dynamic> data) => Account(
        name: data['name'] as String?,
        agentId: data['agent_id'] as int?,
        crmLoginUserId: data['crm_login_user_id'] as dynamic,
        industry: data['industry'] as String?,
        imgurl: data['imgurl'] as dynamic,
        billingCity: data['billing_city'] as String?,
        agent: data['agent'] as String?,
        billingAddressSuite: data['billing_address_suite'] as String?,
        accountType: data['account_type'] as String?,
        phone: data['phone'] as String?,
        billingState: data['billing_state'] as String?,
        billingApiId: data['billing_api_id'] as String?,
        billingAddress: data['billing_address'] as String?,
        zohoAccountId: data['zoho_account_id'] as int?,
        pk: data['pk'] as int?,
        billingZipcode: data['billing_zipcode'] as String?,
        accountnumber: data['accountnumber'] as String?,
        parentAccountId: data['parent_account_id'] as dynamic,
        website: data['website'] as String?,
        billingCountry: data['billing_country'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'agent_id': agentId,
        'crm_login_user_id': crmLoginUserId,
        'industry': industry,
        'imgurl': imgurl,
        'billing_city': billingCity,
        'agent': agent,
        'billing_address_suite': billingAddressSuite,
        'account_type': accountType,
        'phone': phone,
        'billing_state': billingState,
        'billing_api_id': billingApiId,
        'billing_address': billingAddress,
        'zoho_account_id': zohoAccountId,
        'pk': pk,
        'billing_zipcode': billingZipcode,
        'accountnumber': accountnumber,
        'parent_account_id': parentAccountId,
        'website': website,
        'billing_country': billingCountry,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Account].
  factory Account.fromJson(String data) {
    return Account.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Account] to a JSON string.
  String toJson() => json.encode(toMap());

  Account copyWith({
    String? name,
    int? agentId,
    dynamic crmLoginUserId,
    String? industry,
    dynamic imgurl,
    String? billingCity,
    String? agent,
    String? billingAddressSuite,
    String? accountType,
    String? phone,
    String? billingState,
    String? billingApiId,
    String? billingAddress,
    int? zohoAccountId,
    int? pk,
    String? billingZipcode,
    String? accountnumber,
    dynamic parentAccountId,
    String? website,
    String? billingCountry,
  }) {
    return Account(
      name: name ?? this.name,
      agentId: agentId ?? this.agentId,
      crmLoginUserId: crmLoginUserId ?? this.crmLoginUserId,
      industry: industry ?? this.industry,
      imgurl: imgurl ?? this.imgurl,
      billingCity: billingCity ?? this.billingCity,
      agent: agent ?? this.agent,
      billingAddressSuite: billingAddressSuite ?? this.billingAddressSuite,
      accountType: accountType ?? this.accountType,
      phone: phone ?? this.phone,
      billingState: billingState ?? this.billingState,
      billingApiId: billingApiId ?? this.billingApiId,
      billingAddress: billingAddress ?? this.billingAddress,
      zohoAccountId: zohoAccountId ?? this.zohoAccountId,
      pk: pk ?? this.pk,
      billingZipcode: billingZipcode ?? this.billingZipcode,
      accountnumber: accountnumber ?? this.accountnumber,
      parentAccountId: parentAccountId ?? this.parentAccountId,
      website: website ?? this.website,
      billingCountry: billingCountry ?? this.billingCountry,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Account) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      name.hashCode ^
      agentId.hashCode ^
      crmLoginUserId.hashCode ^
      industry.hashCode ^
      imgurl.hashCode ^
      billingCity.hashCode ^
      agent.hashCode ^
      billingAddressSuite.hashCode ^
      accountType.hashCode ^
      phone.hashCode ^
      billingState.hashCode ^
      billingApiId.hashCode ^
      billingAddress.hashCode ^
      zohoAccountId.hashCode ^
      pk.hashCode ^
      billingZipcode.hashCode ^
      accountnumber.hashCode ^
      parentAccountId.hashCode ^
      website.hashCode ^
      billingCountry.hashCode;
}
