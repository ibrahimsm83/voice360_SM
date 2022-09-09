import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFieldWSuffix extends StatelessWidget {
  TextEditingController? textController;
  String? hint;
  bool isReadOnly;
  double? borderRadius;
  Widget? sufixIcon;

  AppTextFieldWSuffix(
      {Key? key,
      @required this.textController,
      @required this.borderRadius = 10,
      @required this.hint,
      @required this.sufixIcon,
      @required this.isReadOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: isReadOnly,
      controller: textController,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        suffixIcon: sufixIcon ?? Container(),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 12.w,
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.all(
            Radius.circular(
              borderRadius!,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.all(
            Radius.circular(
              borderRadius!,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
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
