import 'dart:io';

class Message {
  String? senderName;

  int? senderId;

  String? messageBody;

  File? file;

  String? time;

  Message(
      {this.messageBody, this.senderName, this.file, this.senderId, this.time});
}

final myMessages = <Message>[
  Message(
    messageBody: "Yeah, Sure, you are absolutely correct at your point",
    senderId: 9,
    time: "Today 5:25",
  ),

  Message(
    messageBody: "Yeah, Sure, you are absolutely correct at your point",
    senderId: 9,
    time: "Today 5:22",
  ),

  Message(
    messageBody: "Yeah, Sure, you are absolutely correct at your point",
    senderId: 9,
    time: "Today 5:21",
  ),

  Message(
    messageBody: "Yeah, Sure, you are absolutely correct at your point. ",
    senderId: 1,
    time: "Yesterday 6:21",
  ),

  Message(
      messageBody: "Yeah, Sure, you are absolutely correct at your point.",
      senderId: 9,
      time: "2 days ago 2:25"),

  Message(
      messageBody:
          "I’m sorry, It is not available right now. May I help you with something else?",
      senderId: 2,
      time: "Sat 9 March 22:15"),

  // Message(messageBody: "Let me check that I have this right…", senderId: 1),

  // Message(messageBody: "If I understand you correctly…", senderId: 1),

  // Message(

  //     messageBody:

  //         "Perfect, I am really glad to hear that! How may I help you today?",

  //     senderId: 1),

  // Message(

  //     messageBody: "I’m not sure, but let me find out for you.", senderId: 1),

  // Message(

  //     messageBody:

  //         "May I put your call on hold while I am checking your order?",

  //     senderId: 1),

  // Message(

  //     messageBody:

  //         "I have the details of your latest payment, let me send it over to you.",

  //     senderId: 1),

  // Message(

  //     messageBody:

  //         "I’m sorry, It is not available right now. May I help you with something else?",

  //     senderId: 1),

  // Message(

  // messageBody: "Yeah, Sure, you are absolutely correct at your point",

  // senderId: 9,

  // time: "Sat 9 March 22:15"),

  // Message(messageBody: "Let me check that I have this right…", senderId: 1),

  // Message(messageBody: "If I understand you correctly…", senderId: 1),

  // Message(

  //     messageBody:

  //         "Perfect, I am really glad to hear that! How may I help you today?",

  //     senderId: 1),

  // Message(

  //     messageBody: "Yeah, Sure, you are absolutely correct at your point",

  //     senderId: 9,

  //     time: "2 days ago 2:25"),

  // // Message(

  // //     messageBody: "I’m not sure, but let me find out for you.", senderId: 1),

  // // Message(

  // //     messageBody:

  // //         "May I put your call on hold while I am checking your order?",

  // //     senderId: 1),

  // Message(

  //   messageBody: "Yeah, Sure, you are absolutely correct at your point",

  //   senderId: 9,

  //   time: "Yesterday 6:21",

  // ),

  // Message(

  //   messageBody: "Yeah, Sure, you are absolutely correct at your point. ",

  //   senderId: 1,

  //   time: "Today 5:21",

  // ),

  // // Message(

  // //     messageBody:

  // //         "I have the details of your latest payment, let me send it over to you.",

  // //     senderId: 1),

  // Message(

  //   messageBody: "Yeah, Sure, you are absolutely correct at your point.",

  //   senderId: 9,

  //   time: "Today 5:22",

  // ),

  // // Message(

  // //     messageBody:

  // //         "I’m sorry, It is not available right now. May I help you with something else?",

  // //     senderId: 1),

  // Message(

  //   messageBody:

  //       "I’m sorry, It is not available right now. May I help you with something else?",

  //   senderId: 2,

  //   time: "Today 5:25",

  // ),
];
