import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/get_contacts_reponse_model/contact_response.dart';
import '../repo/contacts_repo.dart';
import '../widgets/custom_toast.dart';
import 'contacts_controller.dart';

class ChatInfoController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  ContactsController contactsController = Get.put(ContactsController());
  String initialName = '';
  int? pk;
  String phone = Get.arguments;
  ContactsRepo repo = ContactsRepo();
  RxBool isLoading = false.obs;

  addContact() async {
    if (fullNameController.text.isEmpty || fullNameController.text == null) {
      CustomToast.showToast("Please enter contact name", true);

      return;
    }
    isLoading.value = true;
    try {
      var res = await repo.createContact(fullNameController.text, 'work', phone, '');
      if (res.runtimeType == String) {
        CustomToast.showToast(res, true);
      }
      if (res.runtimeType == null) {
        CustomToast.showToast("Something went wrong", true);
      }
      if (res) {
        CustomToast.showToast("New contact created successfully", false);
        contactsController.fetchContacts();
        try {
          final res = await repo.getContacts();
          if (res.runtimeType == ContactResponse) {
            for (Contact contact in (res as ContactResponse).result ?? <Contact>[]) {
              if (contact.phone == phone) {
                initialName = contact.firstname ?? '';
                fullNameController.text = contact.firstname ?? "";
                pk = contact.pk;
              }
            }
          }
        } catch (e) {
          null;
        }
      }
    } catch (e) {
      CustomToast.showToast("Something went wrong", true);
    }
    isLoading.value = false;
  }

  updateContact() async {
    if (fullNameController.text.isEmpty || fullNameController.text == null) {
      CustomToast.showToast("Please enter contact name", true);

      return;
    }
    isLoading.value = true;
    try {
      var res = await repo.updateContact(pk, fullNameController.text, 'work', phone, '');
      if (res.runtimeType == String) {
        CustomToast.showToast(res, true);
      }
      if (res.runtimeType == null) {
        CustomToast.showToast("Something went wrong", true);
      }
      if (res) {
        CustomToast.showToast("Updated Contact successfully", false);
        contactsController.fetchContacts();
        try {
          final res = await repo.getContacts();
          if (res.runtimeType == ContactResponse) {
            for (Contact contact in (res as ContactResponse).result ?? <Contact>[]) {
              if (contact.phone == phone) {
                initialName = contact.firstname ?? '';
                fullNameController.text = contact.firstname ?? "";
                pk = contact.pk;
              }
            }
          }
        } catch (e) {
          null;
        }
      }
    } catch (e) {
      CustomToast.showToast("Something went wrong", true);
    }
    isLoading.value = false;
  }

  @override
  void onInit() async {
    isLoading.value = true;
    try {
      final res = await repo.getContacts();
      if (res.runtimeType == ContactResponse) {
        for (Contact contact in (res as ContactResponse).result ?? <Contact>[]) {
          if (contact.phone == phone) {
            initialName = contact.firstname ?? '';
            fullNameController.text = contact.firstname ?? "";
            pk = contact.pk;
          }
        }
      }
    } catch (e) {
      null;
    }
    isLoading.value = false;
    super.onInit();
  }
}
