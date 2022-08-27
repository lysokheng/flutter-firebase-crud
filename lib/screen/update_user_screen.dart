import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateUserScreen extends StatelessWidget {
  final String id;
  UpdateUserScreen( this.id, {Key? key}) : super(key: key);

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController fullnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();



  Future<void> updateUser(String fullname, String lastname) {
    return users
        .doc(id)
        .update({
      'fullname': fullname,
      'lastname': lastname,
    })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Update User'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: fullnameController,
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
                      controller: lastnameController,
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

                  child: const Text('Save'),
                  onPressed: () {
                    updateUser(fullnameController.text, lastnameController.text);
                    fullnameController.clear();
                    lastnameController.clear();
                  },
                ),
              ),
            ],
          ),
        )
    );

  }
}