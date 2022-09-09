class GetSocketInfoResponseModel {
  Result? result;
  bool? errors;
  dynamic error;
  String? message;
  dynamic pageSize;
  dynamic nextStartKey;
  dynamic startKey;

  GetSocketInfoResponseModel(
      {this.result,
      this.errors,
      this.error,
      this.message,
      this.pageSize,
      this.nextStartKey,
      this.startKey});

  GetSocketInfoResponseModel.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    errors = json['errors'];
    error = json['error'];
    message = json['message'];
    pageSize = json['page_size'];
    nextStartKey = json['next_start_key'];
    startKey = json['start_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['errors'] = this.errors;
    data['error'] = this.error;
    data['message'] = this.message;
    data['page_size'] = this.pageSize;
    data['next_start_key'] = this.nextStartKey;
    data['start_key'] = this.startKey;
    return data;
  }
}

class Result {
  String? sipPassword;
  int? pk;
  String? sipUsername;
  int? ownerId;
  String? deviceType;
  int? accountId;

  Result(
      {this.sipPassword,
      this.pk,
      this.sipUsername,
      this.ownerId,
      this.deviceType,
      this.accountId});

  Result.fromJson(Map<String, dynamic> json) {
    sipPassword = json['sip_password'];
    pk = json['pk'];
    sipUsername = json['sip_username'];
    ownerId = json['owner_id'];
    deviceType = json['device_type'];
    accountId = json['account_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sip_password'] = this.sipPassword;
    data['pk'] = this.pk;
    data['sip_username'] = this.sipUsername;
    data['owner_id'] = this.ownerId;
    data['device_type'] = this.deviceType;
    data['account_id'] = this.accountId;
    return data;
  }
}
