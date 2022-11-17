import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordTextField extends StatefulWidget {
  TextEditingController? textController;
  String? hint;
  PasswordTextField({
    Key? key,
    @required this.textController,
    this.hint,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      obscureText: isObsecure,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffF6F7F9),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 12.w,
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(color: Color(0xff838799), fontSize: 14.sp),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isObsecure = !isObsecure;
            });
          },
          child: Icon(isObsecure ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey[800]),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
      ),
    );
  }
}
