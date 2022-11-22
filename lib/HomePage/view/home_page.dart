import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  CollectionReference todoRef =
      FirebaseFirestore.instance.collection('todo collection');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var todoItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 193, 139),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Todo List'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'profile'),
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        // mutiple dcoments get use
        stream: todoRef
            .where('userid', isEqualTo: _auth.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data!.docs);

            final todoItems = snapshot.data!.docs;
            print(todoItems[0]['todoName']);
            print('dfghjkfdsdfghsdfghjk');
            return ListView.builder(
              itemCount: todoItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(todoItems[index]['todoName'].toString()),
                  subtitle: Text(todoItems[index]['Decrption'].toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true, //1
                              context: context,
                              builder: (context) {
                                return ModelTextfield(
                                  buttonType: false,
                                  name: todoItems[index]['todoName'].toString(),
                                  desc:
                                      todoItems[index]['Decrption'].toString(),
                                  Id: todoItems[index]['todoId'].toString(),
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
                child: CircularProgressIndicator()); // provide round
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 81, 193, 139),
        onPressed: () {
          // ignore: inference_failure_on_function_invocation
          showModalBottomSheet(
            isScrollControlled: true, //1
            context: context,
            builder: (context) {
              return ModelTextfield(
                buttonType: true,
                desc: '',
                name: '',
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
