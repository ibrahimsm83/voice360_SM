import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/base_screen_controller.dart';
import 'package:itp_voice/repo/contacts_repo.dart';
import 'package:itp_voice/repo/shares_preference_repo.dart';
import 'package:itp_voice/screens/call_history_screen.dart';
import 'package:itp_voice/storage_keys.dart';
import 'package:itp_voice/widgets/custom_widgets/dialpad/flutter_dialpad.dart';

import '../app_theme.dart';

class HomeScreen extends StatefulWidget {
  final String? initialValue;
  HomeScreen({
    Key? key,
    this.initialValue,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showDialpad = true;
  BaseScreenController con = Get.find<BaseScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: showDialpad
                ? DialPad(
                    enableDtmf: false,
                    initialValue: widget.initialValue,
                    outputMask: "00000000000",
                    backspaceButtonIconColor: Colors.red,
                    makeCall: (number) async {
                      print(number);
                      con.handleCall(number, context);
                      // var apiRes = await ContactsRepo().getContacts();
                      // print(apiRes.toString());
                    },
                  )
                : CallHistoryScreen(),
          ),
          const SizedBox(height: 15),
          if (widget.initialValue == null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showDialpad = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: showDialpad
                              ? Theme.of(context).colorScheme.secondary
                              : AppTheme.colors(context)?.unselectionColor ?? Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      "Keypad",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: showDialpad
                            ? Theme.of(context).colorScheme.secondary
                            : AppTheme.colors(context)?.unselectionColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showDialpad = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: !showDialpad
                              ? Theme.of(context).colorScheme.secondary
                              : AppTheme.colors(context)?.unselectionColor ?? Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      "Call History",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: !showDialpad
                            ? Theme.of(context).colorScheme.secondary
                            : AppTheme.colors(context)?.unselectionColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (widget.initialValue == null) const SizedBox(height: 15),
        ],
      ),
    );
  }
}
