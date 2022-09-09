class GetMessageThreadsResponseModel {
  Result? result;
  bool? errors;
  Null? error;
  String? message;
  Null? pageSize;
  Null? nextStartKey;
  Null? startKey;

  GetMessageThreadsResponseModel(
      {this.result,
      this.errors,
      this.error,
      this.message,
      this.pageSize,
      this.nextStartKey,
      this.startKey});

  GetMessageThreadsResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<MessageThreads>? messageThreads;
  int? totalPages;
  int? page;

  Result({this.messageThreads, this.totalPages, this.page});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['message_threads'] != null) {
      messageThreads = <MessageThreads>[];
      json['message_threads'].forEach((v) {
        messageThreads!.add(new MessageThreads.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messageThreads != null) {
      data['message_threads'] =
          this.messageThreads!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['page'] = this.page;
    return data;
  }
}

class MessageThreads {
  bool? threadRead;
  String? lastMessage;
  String? lastUpdated;
  int? numberOfParticipants;
  int? pk;
  List<Participants>? participants;

  MessageThreads(
      {this.threadRead,
      this.lastMessage,
      this.lastUpdated,
      this.numberOfParticipants,
      this.pk,
      this.participants});

  MessageThreads.fromJson(Map<String, dynamic> json) {
    threadRead = json['thread_read'];
    lastMessage = json['last_message'];
    lastUpdated = json['last_updated'];
    numberOfParticipants = json['number_of_participants'];
    pk = json['pk'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thread_read'] = this.threadRead;
    data['last_message'] = this.lastMessage;
    data['last_updated'] = this.lastUpdated;
    data['number_of_participants'] = this.numberOfParticipants;
    data['pk'] = this.pk;
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
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
