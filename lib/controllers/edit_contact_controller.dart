import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:itp_voice/controllers/contacts_controller.dart';
import 'package:itp_voice/helpers/config.dart';
import 'package:itp_voice/models/add_contact_request_model/add_contact_request_model.dart';
import 'package:itp_voice/models/add_contact_request_model/email.dart';
import 'package:itp_voice/models/add_contact_request_model/number.dart';
import 'package:itp_voice/models/get_contacts_reponse_model/user_contact.dart';
import 'package:itp_voice/repo/contacts_repo.dart';
import 'package:itp_voice/widgets/custom_loader.dart';
import 'package:itp_voice/widgets/custom_toast.dart';
import 'package:itp_voice/widgets/phone_number_field.dart';

import '../models/get_contacts_reponse_model/contact_response.dart';

class EditContactController extends GetxController {
  RxInt phoneNumberCount = 1.obs;
  RxString selectedValues = "Option 1".obs;
  ContactsRepo contactsRepo = ContactsRepo();
  ContactsController contactsController = Get.find<ContactsController>();
  Contact? contact;
  List<String> options = [
    "Option 1",
    "Option 2",
    "Option 3",
  ];

  List<String> contactsLabels = [
    "Work",
    "Home",
    "Mobile",
    "Others",
  ];

  List<String> emailLabels = [
    "Work",
    "Home",
    "Others",
  ];
  List<Map<String, dynamic>> contactFieldsData = [];
  List<Map<String, dynamic>> emailFieldsData = [];
  TextEditingController get fullNameController => TextEditingController(text: contact!.firstname!);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    contact = Get.arguments['contact'];
    print(contact);
    addNewContactField();
    addNewEmailField();
  }

  addNewContactField() async {
    contactFieldsData.add({
      "labelOptions": contactsLabels,
      "selectedLabel":
          contactsLabels.indexWhere((element) => element.toLowerCase() == (contact?.notes?.toLowerCase() ?? "work")),
      "code": "92",
      "controller": TextEditingController()
    });
    update();
  }

  // addNewContactField() async {
  //   for (int i = 0; i < contact!.numbers!.length; i++) {
  //     contactFieldsData.add({
  //       "labelOptions": contactsLabels,
  //       "selectedLabel": contactsLabels.indexWhere((element) =>
  //           element.toLowerCase() == contact!.numbers![i].label!.toLowerCase()),
  //       "code": "92",
  //       "controller": TextEditingController()
  //     });
  //     update();
  //   }
  // }

  removeContactField(int index) async {
    contactFieldsData.removeAt(index);
    update();
  }

  addNewEmailField() async {
    emailFieldsData.add(
        {"labelOptions": emailLabels, "selectedLabel": 0, "controller": TextEditingController(text: contact!.email!)});
    update();
  }

  // addNewEmailField() async {
  //   emailFieldsData.add({
  //     "labelOptions": emailLabels,
  //     "selectedLabel": 0,
  //     "controller": TextEditingController()
  //   });
  //   update();
  // }

  removeEmailField(int index) async {
    emailFieldsData.removeAt(index);
    update();
  }

  saveContact() async {
    bool isFormValid = validateForms();
    if (isFormValid) {
      List<Number> numbers = [];
      List<Email> emails = [];
      for (var i = 0; i < emailFieldsData.length; i++) {
        Email email = Email(
          label: emailLabels[emailFieldsData[i]['selectedLabel']],
          email: emailFieldsData[i]['controller'].text,
        );

        emails.add(email);
      }

      for (var i = 0; i < contactFieldsData.length; i++) {
        Number number = Number(
          label: contactsLabels[contactFieldsData[i]['selectedLabel']],
          number: "+${contactFieldsData[i]['code']}" + contactFieldsData[i]['controller'].text,
        );
        numbers.add(number);
      }

      AddContactRequestModel requestData = AddContactRequestModel(
        name: fullNameController.text,
        numbers: numbers,
        emails: emails,
        email: "",
        labelEmail: "",
        number: "",
        notes: "",
        labelNumber: "",
      );

      Get.focusScope!.unfocus();
      CustomLoader.showLoader();
      try {
        var res = await contactsRepo.updateContact(contact!.pk, fullNameController.text, numbers[0].label ?? '',
            numbers[0].number ?? '', emails[0].email ?? '');
        Get.back();
        if (res.runtimeType == String) {
          CustomToast.showToast(res, true);
          return;
        }
        if (res.runtimeType == null) {
          CustomToast.showToast("Something went wrong", true);
          return;
        }
        if (res) {
          Get.back();
          CustomToast.showToast("Contact updated successfully", false);
          contactsController.fetchContacts();
          return;
        }
      } catch (e) {
        Get.back();
        CustomToast.showToast("Something went wrong", true);
      }
    }
  }

  validateForms() {
    RegExp phoneRegexp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

    if (fullNameController.text.isEmpty || fullNameController.text == null) {
      CustomToast.showToast("Please enter contact name", true);

      return false;
    }

    for (int i = 0; i < contactFieldsData.length; i++) {
      if (contactFieldsData[i]['controller'].text.toString().isEmpty ||
          contactFieldsData[i]['controller'].text == null) {
        CustomToast.showToast("Please enter a phone number", true);
        return false;
      }
      if (!phoneRegexp.hasMatch(contactFieldsData[i]['controller'].text.toString())) {
        CustomToast.showToast("Please enter a valid phone number", true);
        return false;
      }
    }

    for (int i = 0; i < emailFieldsData.length; i++) {
      if (emailFieldsData[i]['controller'].text.toString().isEmpty || emailFieldsData[i]['controller'].text == null) {
        CustomToast.showToast("Please enter an email", true);
        return false;
      }

      bool isEmailValid = EmailValidator.validate(emailFieldsData[i]['controller'].text);
      if (!isEmailValid) {
        CustomToast.showToast("Please enter a valid email", true);
        return false;
      }
    }
    return true;
  }
}
