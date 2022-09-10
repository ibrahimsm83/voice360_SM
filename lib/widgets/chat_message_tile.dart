import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itp_voice/models/message.dart';

class MyMessageChatTile extends StatelessWidget {
  final double minValue = 8.0;
  final String? message;
  final bool isCurrentUser;
  final String deliveryTime;

  MyMessageChatTile(
      {this.message, required this.isCurrentUser, required this.deliveryTime});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: [
            Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: isCurrentUser ? 60.w : 15.w,
                      right: isCurrentUser ? 15.w : 60.w),
                  padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  child: Bubble(
                    elevation: 0,
                    style: BubbleStyle(
                        // nipRadius: 0,

                        radius: Radius.circular(10),
                        padding: BubbleEdges.all(7)),
                    nip: isCurrentUser ? BubbleNip.rightTop : BubbleNip.leftTop,
                    color: isCurrentUser
                        ? Theme.of(context).colorScheme.primary
                        : Color(0xffEAE9E9),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(height: 5.w),
                          SelectableText(
                            "${message}",
                            minLines: 2,
                            maxLines: 6,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color:
                                  isCurrentUser ? Colors.white : Colors.black,
                            ),
                          ),
                        ]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: isCurrentUser ? 0 : 25.w,
                    right: isCurrentUser ? 25.w : 0,
                  ),
                  child: Text(
                    // "23:12 AM",
                    deliveryTime,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 12.sp,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}
