import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_firebase/screen/add_user_screen.dart';
import 'package:learning_firebase/screen/update_user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> deleteUser(String id) {
    return users
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  void deleteData(BuildContext context) {
    debugPrint(context.widget.key.toString());
  }


  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase'), actions: [
        IconButton(
          onPressed: () => Get.to(AddUserScreen()),
          icon: const Icon(Icons.add),
        ),
      ]),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                leading: InkWell(
                  onTap: () {
                    Get.to(UpdateUserScreen(document.id));
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.blueAccent,
                  ),
                ),
                title: Text(data['fullname']),
                subtitle: Text(data['lastname']),
                trailing: InkWell(
                  onTap: () {
                    deleteUser(document.id);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
