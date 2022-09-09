import 'dart:convert';

import 'package:collection/collection.dart';

class VoiceMails {
  String? macrocontext;
  String? context;
  String? msgId;
  int? duration;
  int? origtime;
  String? flag;
  String? mailboxcontext;
  int? pk;
  String? mailboxuser;
  String? callerid;
  int? msgnum;
  dynamic category;
  String? dir;
  String? usertime;

  VoiceMails({
    this.macrocontext,
    this.context,
    this.msgId,
    this.duration,
    this.origtime,
    this.flag,
    this.mailboxcontext,
    this.pk,
    this.mailboxuser,
    this.callerid,
    this.msgnum,
    this.category,
    this.dir,
    this.usertime,
  });

  @override
  String toString() {
    return 'VoiceMails(macrocontext: $macrocontext, context: $context, msgId: $msgId, duration: $duration, origtime: $origtime, flag: $flag, mailboxcontext: $mailboxcontext, pk: $pk, mailboxuser: $mailboxuser, callerid: $callerid, msgnum: $msgnum, category: $category, dir: $dir, usertime: $usertime)';
  }

  factory VoiceMails.fromMap(Map<String, dynamic> data) => VoiceMails(
        macrocontext: data['macrocontext'] as String?,
        context: data['context'] as String?,
        msgId: data['msg_id'] as String?,
        duration: data['duration'] as int?,
        origtime: data['origtime'] as int?,
        flag: data['flag'] as String?,
        mailboxcontext: data['mailboxcontext'] as String?,
        pk: data['pk'] as int?,
        mailboxuser: data['mailboxuser'] as String?,
        callerid: data['callerid'] as String?,
        msgnum: data['msgnum'] as int?,
        category: data['category'] as dynamic,
        dir: data['dir'] as String?,
        usertime: data['usertime'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'macrocontext': macrocontext,
        'context': context,
        'msg_id': msgId,
        'duration': duration,
        'origtime': origtime,
        'flag': flag,
        'mailboxcontext': mailboxcontext,
        'pk': pk,
        'mailboxuser': mailboxuser,
        'callerid': callerid,
        'msgnum': msgnum,
        'category': category,
        'dir': dir,
        'usertime': usertime,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [VoiceMails].
  factory VoiceMails.fromJson(String data) {
    return VoiceMails.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [VoiceMails] to a JSON string.
  String toJson() => json.encode(toMap());

  VoiceMails copyWith({
    String? macrocontext,
    String? context,
    String? msgId,
    int? duration,
    int? origtime,
    String? flag,
    String? mailboxcontext,
    int? pk,
    String? mailboxuser,
    String? callerid,
    int? msgnum,
    dynamic category,
    String? dir,
    String? usertime,
  }) {
    return VoiceMails(
      macrocontext: macrocontext ?? this.macrocontext,
      context: context ?? this.context,
      msgId: msgId ?? this.msgId,
      duration: duration ?? this.duration,
      origtime: origtime ?? this.origtime,
      flag: flag ?? this.flag,
      mailboxcontext: mailboxcontext ?? this.mailboxcontext,
      pk: pk ?? this.pk,
      mailboxuser: mailboxuser ?? this.mailboxuser,
      callerid: callerid ?? this.callerid,
      msgnum: msgnum ?? this.msgnum,
      category: category ?? this.category,
      dir: dir ?? this.dir,
      usertime: usertime ?? this.usertime,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! VoiceMails) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      macrocontext.hashCode ^
      context.hashCode ^
      msgId.hashCode ^
      duration.hashCode ^
      origtime.hashCode ^
      flag.hashCode ^
      mailboxcontext.hashCode ^
      pk.hashCode ^
      mailboxuser.hashCode ^
      callerid.hashCode ^
      msgnum.hashCode ^
      category.hashCode ^
      dir.hashCode ^
      usertime.hashCode;
}
