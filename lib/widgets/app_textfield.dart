import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  TextEditingController? textController;
  String? hint;
  bool isReadOnly;
  double? borderRadius;
  TextAlign? textAlign;

  AppTextField(
      {Key? key,
      @required this.textController,
      @required this.borderRadius = 10,
      @required this.hint,
      @required this.isReadOnly = false,
      @required this.textAlign = TextAlign.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: isReadOnly,
      textAlign: textAlign!,
      style: Theme.of(context).textTheme.bodyText1,
      controller: textController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffF6F7F9),
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
