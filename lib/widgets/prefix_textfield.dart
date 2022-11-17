import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itp_voice/app_theme.dart';

class AppTextFieldWPrefix extends StatelessWidget {
  TextEditingController? textController;
  String? hint;
  bool isReadOnly;
  double? borderRadius;
  Widget? sufixIcon;
  TextAlign? textAlign;
  TextInputType keyboardType;

  AppTextFieldWPrefix(
      {Key? key,
      @required this.textController,
      @required this.borderRadius = 10,
      @required this.hint,
      @required this.sufixIcon,
      @required this.isReadOnly = false,
      @required this.textAlign = TextAlign.left,
      @required this.keyboardType = TextInputType.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: isReadOnly,
      textAlign: textAlign!,
      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black),
      controller: textController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffF6F7F9),
        prefixIcon: sufixIcon ?? Container(),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 12.w,
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Color(0xff838799), fontSize: 14.sp),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(
              borderRadius!,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(
              borderRadius!,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(
              borderRadius!,
            ),
          ),
        ),
      ),
    );
  }
}
