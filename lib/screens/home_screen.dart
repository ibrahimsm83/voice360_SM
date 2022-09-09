import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/base_screen_controller.dart';
import 'package:itp_voice/repo/contacts_repo.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/storage_keys.dart';
import 'package:itp_voice/widgets/custom_widgets/dialpad/flutter_dialpad.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  BaseScreenController con = Get.find<BaseScreenController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DialPad(
        enableDtmf: false,
        outputMask: "0000000000",
        backspaceButtonIconColor: Colors.red,
        makeCall: (number) async {
          con.handleCall(number, context);
          // var apiRes = await ContactsRepo().getContacts();
          // print(apiRes.toString());
        },
      ),
    );
  }
}
