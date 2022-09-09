import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/call_screen_controller.dart';
import 'package:itp_voice/widgets/custom_widgets/dialpad/flutter_dialpad.dart';

class InCallDialPad extends StatelessWidget {
  InCallDialPad({Key? key}) : super(key: key);
  CallScreenController con = Get.find<CallScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: DialPad(
          // dialButtonIcon: Icons.arrow_back_ios,
          enableDtmf: false,
          outputMask: "0000000000",
          backspaceButtonIconColor: Colors.red,
          hideDialButton: true,
          keyPressed: (value) {
            print(value);
            con.handleDtmf(value.toString());
          },
        ),
      ),
    );
  }
}
