import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:learning_firebase/screen/update_user_screen.dart';

class HomeController extends GetxController{
  String? docId;
  String? fullname;
  String? lastname;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> deleteUser(String id) {
    return users
        .doc(id)
        .delete()
        .then((value) => Get.snackbar('Message', 'User has been deleted'))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  void onClickUpdate(
      {required String docID,
        required String fullname,
        required String lastname}) {
    docId = docID;
    this.fullname = fullname;
    this.lastname = lastname;
    Get.to(() => UpdateUserScreen());
  }
}