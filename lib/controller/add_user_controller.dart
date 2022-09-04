import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddUserController extends GetxController {
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController fullnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  Future<void> addUser(String fullname, String lastname) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'fullname': fullname,
          'lastname': lastname,
        })
        .then((value) => Get.snackbar('Message', 'User Added'))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void onSave() {
    String fullname = fullnameController.text;
    String lastname = lastnameController.text;

    if (fullname.isEmpty && lastname.isEmpty) {
      Get.snackbar('Message', 'Please enter fullname and lastname');
      return;
    } else if (fullname.isEmpty) {
      Get.snackbar('Message', 'Please enter fullname');
      return;
    } else if (lastname.isEmpty) {
      Get.snackbar('Message', 'Please enter lastname');
      return;
    }
    addUser(fullname, lastname);
    fullnameController.clear();
    lastnameController.clear();
    Get.back();
  }
}
