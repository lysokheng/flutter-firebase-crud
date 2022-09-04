import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learning_firebase/controller/home_controller.dart';

class UpdateUserController extends GetxController {
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final fullnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final homeController = Get.find<HomeController>();
  String? docId;

  @override
  void onInit() {
    fullnameController.text = homeController.fullname!;
    lastnameController.text = homeController.lastname!;
    docId = homeController.docId;

    super.onInit();
  }

  Future<void> updateUser(String fullname, String lastname) {
    return users
        .doc(docId)
        .update({
          'fullname': fullname,
          'lastname': lastname,
        })
        .then((value) => Get.snackbar('Message', 'User has been updated'))
        .catchError((error) => print("Failed to update user: $error"));
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
    Get.back();
    updateUser(fullname, lastname);
  }
}
