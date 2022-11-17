import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_cupertino.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itp_voice/helpers/config.dart';
import 'package:itp_voice/widgets/prefix_textfield.dart';

class PhoneNumberField extends StatelessWidget {
  String? hint;
  TextEditingController? textController;
  Function? onChanged;
  bool readOnly;
  PhoneNumberField({
    Key? key,
    this.hint,
    this.textController,
    this.onChanged,
    this.readOnly = false,
  }) : super(key: key);
  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: 15.h, width: 25.w, child: CountryPickerUtils.getDefaultFlagImage(country)),
            SizedBox(
              width: 8.0,
            ),
            Text(
              "+${country.phoneCode}",
              style: TextStyle(fontSize: 14.sp, color: Colors.black),
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return AppTextFieldWPrefix(
      isReadOnly: readOnly,
      textAlign: TextAlign.left,
      textController: textController,
      hint: hint,
      keyboardType: TextInputType.number,
      sufixIcon: Container(
        width: 150.w,
        decoration: BoxDecoration(
            color: Color(0xffF6F7F9),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                CountryPickerDropdown(
                  initialValue: 'US',
                  iconSize: 15.sp,
                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                  isDense: true,
                  itemBuilder: _buildDropdownItem,
                  sortComparator: (Country a, Country b) => a.phoneCode.compareTo(b.phoneCode),
                  onValuePicked: (Country country) {
                    onChanged!(country.phoneCode);
                  },
                ),
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Container(
              height: 20.h,
              width: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
