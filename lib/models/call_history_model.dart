class CallHistory {
  String? name;
  DateTime? time;
  bool? isIncoming;
  String? numberToDial;
  bool? isMissed;

  CallHistory(
      {this.name,
      this.time,
      this.isIncoming,
      this.isMissed,
      this.numberToDial});
}
