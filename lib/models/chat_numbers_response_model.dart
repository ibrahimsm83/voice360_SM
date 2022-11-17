class ChatNumbersResponse {
  List<Result>? result;
  bool? errors;
  Null? error;
  String? message;

  ChatNumbersResponse({this.result, this.errors, this.error, this.message});

  ChatNumbersResponse.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
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

class Result {
  // List<Null>? faxAssignedUsers;
  String? status;
  int? ownerId;
  String? description;
  String? calleridPrefix;
  List<SmsAssignedUsers>? smsAssignedUsers;
  String? number;
  int? accountId;
  int? pk;
  String? callerIdName;
  String? usedBy;

  Result(
      {
      // this.faxAssignedUsers,
      this.status,
      this.ownerId,
      this.description,
      this.calleridPrefix,
      this.smsAssignedUsers,
      this.number,
      this.accountId,
      this.pk,
      this.callerIdName,
      this.usedBy});

  Result.fromJson(Map<String, dynamic> json) {
    // if (json['fax_assigned_users'] != null) {
    //   faxAssignedUsers = <Null>[];
    //   json['fax_assigned_users'].forEach((v) {
    //     faxAssignedUsers!.add(new Null.fromJson(v));
    //   });
    // }
    status = json['status'];
    ownerId = json['owner_id'];
    description = json['description'];
    calleridPrefix = json['callerid_prefix'];
    if (json['sms_assigned_users'] != null) {
      smsAssignedUsers = <SmsAssignedUsers>[];
      json['sms_assigned_users'].forEach((v) {
        smsAssignedUsers!.add(new SmsAssignedUsers.fromJson(v));
      });
    }
    number = json['number'];
    accountId = json['account_id'];
    pk = json['pk'];
    callerIdName = json['caller_id_name'];
    usedBy = json['used_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.faxAssignedUsers != null) {
    //   data['fax_assigned_users'] =
    //       this.faxAssignedUsers!.map((v) => v.toJson()).toList();
    // }
    data['status'] = this.status;
    data['owner_id'] = this.ownerId;
    data['description'] = this.description;
    data['callerid_prefix'] = this.calleridPrefix;
    if (this.smsAssignedUsers != null) {
      data['sms_assigned_users'] = this.smsAssignedUsers!.map((v) => v.toJson()).toList();
    }
    data['number'] = this.number;
    data['account_id'] = this.accountId;
    data['pk'] = this.pk;
    data['caller_id_name'] = this.callerIdName;
    data['used_by'] = this.usedBy;
    return data;
  }
}

class SmsAssignedUsers {
  int? crmContactId;
  String? defaultOutboundCalleridName;
  String? presenceId;
  String? defaultOutboundCalleridNumber;
  String? privLevel;
  Null? status;
  String? callRecordingInternal;
  bool? vmToEmailEnabled;
  int? userVolumePreference;
  bool? callforwardEnable;
  int? pk;
  String? callforwardNumber;
  String? voicemailBoxId;
  bool? callforwardKeepCallerCallerId;
  String? callRecordingExternal;
  int? accountId;
  bool? callforwardQueueCalls;
  bool? voicemailEnabled;

  SmsAssignedUsers(
      {this.crmContactId,
      this.defaultOutboundCalleridName,
      this.presenceId,
      this.defaultOutboundCalleridNumber,
      this.privLevel,
      this.status,
      this.callRecordingInternal,
      this.vmToEmailEnabled,
      this.userVolumePreference,
      this.callforwardEnable,
      this.pk,
      this.callforwardNumber,
      this.voicemailBoxId,
      this.callforwardKeepCallerCallerId,
      this.callRecordingExternal,
      this.accountId,
      this.callforwardQueueCalls,
      this.voicemailEnabled});

  SmsAssignedUsers.fromJson(Map<String, dynamic> json) {
    crmContactId = json['crm_contact_id'];
    defaultOutboundCalleridName = json['default_outbound_callerid_name'];
    presenceId = json['presence_id'];
    defaultOutboundCalleridNumber = json['default_outbound_callerid_number'];
    privLevel = json['priv_level'];
    status = json['status'];
    callRecordingInternal = json['call_recording_internal'];
    vmToEmailEnabled = json['vm_to_email_enabled'];
    userVolumePreference = json['user_volume_preference'];
    callforwardEnable = json['callforward_enable'];
    pk = json['pk'];
    callforwardNumber = json['callforward_number'];
    voicemailBoxId = json['voicemail_box_id'];
    callforwardKeepCallerCallerId = json['callforward_keep_caller_caller_id'];
    callRecordingExternal = json['call_recording_external'];
    accountId = json['account_id'];
    callforwardQueueCalls = json['callforward_queue_calls'];
    voicemailEnabled = json['voicemail_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crm_contact_id'] = this.crmContactId;
    data['default_outbound_callerid_name'] = this.defaultOutboundCalleridName;
    data['presence_id'] = this.presenceId;
    data['default_outbound_callerid_number'] = this.defaultOutboundCalleridNumber;
    data['priv_level'] = this.privLevel;
    data['status'] = this.status;
    data['call_recording_internal'] = this.callRecordingInternal;
    data['vm_to_email_enabled'] = this.vmToEmailEnabled;
    data['user_volume_preference'] = this.userVolumePreference;
    data['callforward_enable'] = this.callforwardEnable;
    data['pk'] = this.pk;
    data['callforward_number'] = this.callforwardNumber;
    data['voicemail_box_id'] = this.voicemailBoxId;
    data['callforward_keep_caller_caller_id'] = this.callforwardKeepCallerCallerId;
    data['call_recording_external'] = this.callRecordingExternal;
    data['account_id'] = this.accountId;
    data['callforward_queue_calls'] = this.callforwardQueueCalls;
    data['voicemail_enabled'] = this.voicemailEnabled;
    return data;
  }
}
