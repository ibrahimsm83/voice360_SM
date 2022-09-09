import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextBox extends StatelessWidget {
  String text;
  double? height;
  double? width;
  double? singleCharFontSize;
  double? doubleCharFontSize;
  TextBox({
    Key? key,
    required this.text,
    this.height,
    this.width,
    this.singleCharFontSize,
    this.doubleCharFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height == null ? 50.h : height,
      width: width == null ? 50.w : width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xffF5F8FF),
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Text(
        "${text}",
        style: TextStyle(
          color: Color(0xff2960EC),
          fontWeight: FontWeight.bold,
          fontSize: text.length > 1
              ? doubleCharFontSize == null
                  ? 17.sp
                  : doubleCharFontSize
              : singleCharFontSize == null
                  ? 24.sp
                  : singleCharFontSize,
        ),
      ),
    );
  }
}
