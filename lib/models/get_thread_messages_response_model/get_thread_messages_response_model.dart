class GetThreadMessagesResponseModel {
  Result? result;
  bool? errors;
  dynamic error;
  String? message;
  dynamic pageSize;
  dynamic nextStartKey;
  dynamic startKey;

  GetThreadMessagesResponseModel(
      {this.result,
      this.errors,
      this.error,
      this.message,
      this.pageSize,
      this.nextStartKey,
      this.startKey});

  GetThreadMessagesResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Messages>? messages;
  List<Participants>? participants;

  Result({this.messages, this.participants});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? messageStatus;
  int? pk;
  String? messageBody;
  String? messageProviderId;
  dynamic messageMmsMedia;
  CallBackResponse? callBackResponse;
  String? messageTimestamp;
  String? messageParticipantId;
  String? messageParticipant;

  Messages(
      {this.messageStatus,
      this.pk,
      this.messageBody,
      this.messageProviderId,
      this.messageMmsMedia,
      this.callBackResponse,
      this.messageTimestamp,
      this.messageParticipantId,
      this.messageParticipant});

  Messages.fromJson(Map<String, dynamic> json) {
    messageStatus = json['message_status'];
    pk = json['pk'];
    messageBody = json['message_body'];
    messageProviderId = json['message_provider_id'];
    messageMmsMedia = json['message_mms_media'];
    callBackResponse = json['call_back_response'] != null
        ? new CallBackResponse.fromJson(json['call_back_response'])
        : null;
    messageTimestamp = json['message_timestamp'];
    messageParticipantId = json['message_participant_id'];
    messageParticipant = json['message_participant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message_status'] = this.messageStatus;
    data['pk'] = this.pk;
    data['message_body'] = this.messageBody;
    data['message_provider_id'] = this.messageProviderId;
    data['message_mms_media'] = this.messageMmsMedia;
    if (this.callBackResponse != null) {
      data['call_back_response'] = this.callBackResponse!.toJson();
    }
    data['message_timestamp'] = this.messageTimestamp;
    data['message_participant_id'] = this.messageParticipantId;
    data['message_participant'] = this.messageParticipant;
    return data;
  }
}

class CallBackResponse {
  CallBackResponse();

  CallBackResponse.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class Participants {
  String? messageThreadId;
  int? pk;
  String? number;
  bool? isSelf;

  Participants({this.messageThreadId, this.pk, this.number, this.isSelf});

  Participants.fromJson(Map<String, dynamic> json) {
    messageThreadId = json['message_thread_id'];
    pk = json['pk'];
    number = json['number'];
    isSelf = json['is_self'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message_thread_id'] = this.messageThreadId;
    data['pk'] = this.pk;
    data['number'] = this.number;
    data['is_self'] = this.isSelf;
    return data;
  }
}
