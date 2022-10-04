class ContactResponse {
  List<Contact>? result;
  bool? errors;
  Null? error;
  String? message;

  ContactResponse({this.result, this.errors, this.error, this.message});

  ContactResponse.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Contact>[];
      json['result'].forEach((v) {
        result!.add(new Contact.fromJson(v));
      });
    }
    errors = json['errors'];
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['errors'] = this.errors;
    data['error'] = this.error;
    data['message'] = this.message;
    return data;
  }
}

class Contact {
  bool? publicContact;
  Null? facebookRefId;
  String? notes;
  String? dateAdded;
  Null? zipcode;
  bool? possibleDupe;
  Null? mobile;
  Null? facebookUsername;
  Null? city;
  String? email;
  Null? taggingHistory;
  int? userId;
  bool? qualified;
  int? accountId;
  String? phone;
  String? dateModified;
  bool? isCustomer;
  int? pk;
  Null? formref;
  Null? funnelRefId;
  Null? state;
  Null? address;
  Null? businessIndustry;
  Null? trackRefId;
  Null? contactGuid;
  String? lastname;
  String? firstname;
  int? contactListId;
  Null? businessName;
  String? lastContacted;
  Null? website;

  Contact(
      {this.publicContact,
      this.facebookRefId,
      this.notes,
      this.dateAdded,
      this.zipcode,
      this.possibleDupe,
      this.mobile,
      this.facebookUsername,
      this.city,
      this.email,
      this.taggingHistory,
      this.userId,
      this.qualified,
      this.accountId,
      this.phone,
      this.dateModified,
      this.isCustomer,
      this.pk,
      this.formref,
      this.funnelRefId,
      this.state,
      this.address,
      this.businessIndustry,
      this.trackRefId,
      this.contactGuid,
      this.lastname,
      this.firstname,
      this.contactListId,
      this.businessName,
      this.lastContacted,
      this.website});

  Contact.fromJson(Map<String, dynamic> json) {
    publicContact = json['public_contact'];
    facebookRefId = json['facebook_ref_id'];
    notes = json['notes'];
    dateAdded = json['date_added'];
    zipcode = json['zipcode'];
    possibleDupe = json['possible_dupe'];
    mobile = json['mobile'];
    facebookUsername = json['facebook_username'];
    city = json['city'];
    email = json['email'];
    taggingHistory = json['tagging_history'];
    userId = json['user_id'];
    qualified = json['qualified'];
    accountId = json['account_id'];
    phone = json['phone'];
    dateModified = json['date_modified'];
    isCustomer = json['is_customer'];
    pk = json['pk'];
    formref = json['formref'];
    funnelRefId = json['funnel_ref_id'];
    state = json['state'];
    address = json['address'];
    businessIndustry = json['business_industry'];
    trackRefId = json['track_ref_id'];
    contactGuid = json['contact_guid'];
    lastname = json['lastname'];
    firstname = json['firstname'];
    contactListId = json['contact_list_id'];
    businessName = json['business_name'];
    lastContacted = json['last_contacted'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['public_contact'] = this.publicContact;
    data['facebook_ref_id'] = this.facebookRefId;
    data['notes'] = this.notes;
    data['date_added'] = this.dateAdded;
    data['zipcode'] = this.zipcode;
    data['possible_dupe'] = this.possibleDupe;
    data['mobile'] = this.mobile;
    data['facebook_username'] = this.facebookUsername;
    data['city'] = this.city;
    data['email'] = this.email;
    data['tagging_history'] = this.taggingHistory;
    data['user_id'] = this.userId;
    data['qualified'] = this.qualified;
    data['account_id'] = this.accountId;
    data['phone'] = this.phone;
    data['date_modified'] = this.dateModified;
    data['is_customer'] = this.isCustomer;
    data['pk'] = this.pk;
    data['formref'] = this.formref;
    data['funnel_ref_id'] = this.funnelRefId;
    data['state'] = this.state;
    data['address'] = this.address;
    data['business_industry'] = this.businessIndustry;
    data['track_ref_id'] = this.trackRefId;
    data['contact_guid'] = this.contactGuid;
    data['lastname'] = this.lastname;
    data['firstname'] = this.firstname;
    data['contact_list_id'] = this.contactListId;
    data['business_name'] = this.businessName;
    data['last_contacted'] = this.lastContacted;
    data['website'] = this.website;
    return data;
  }
}
