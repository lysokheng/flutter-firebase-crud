import 'package:flutter/material.dart';
import 'package:learning_firebase/controller/add_user_controller.dart';
import 'package:get/get.dart';
import 'package:learning_firebase/screen/home_screen.dart';

class AddUserScreen extends StatelessWidget {
  AddUserScreen({Key? key}) : super(key: key);

  AddUserController controller = Get.put(AddUserController());


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.fullnameController,
                    decoration: const InputDecoration(
                      labelText: 'fullname',
                      focusColor: Colors.white,

                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.lastnameController,
                    decoration: const InputDecoration(
                      labelText: 'lastname',
                      focusColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  primary: Colors.white,
                ),

                child: const Text('Add'),
                onPressed: () {
                  controller.onSave();
                },
              ),
            ),
          ],
        ),
      )
    );

  }
}