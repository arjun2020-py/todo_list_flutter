import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ModelTextfield extends StatelessWidget {
  ModelTextfield(
      {Key? key, required this.buttonType, this.name, this.desc, this.Id})
      : super(key: key);
  // ignore: non_constant_identifier_names
  String? Id;
  bool buttonType;
  String? name;
  String? desc;
  final todoRef = FirebaseFirestore.instance.collection('todo collection');

  //create a  controller for two textfiled
  late TextEditingController todoNameController =
          TextEditingController(text: name),
      todoDecrptionController = TextEditingController(text: desc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets, //2
      child: Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 280),
              child: Text(
                (buttonType) ? 'Add Todo' : 'Update todo',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: todoNameController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Todo here',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: todoDecrptionController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Todo descrption',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              child: ElevatedButton(
                onPressed: () {
                  if (buttonType) {
                    createTodo(
                      name: todoNameController.text,
                      decrption: todoDecrptionController.text,
                    );
                    Navigator.pop(context);
                  } else {
                    updateTodo(
                      todoName: todoNameController.text,
                      Decrption: todoDecrptionController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text((buttonType) ? 'Save' : 'Update'),
              ),
            )
          ],
        ),
      ),
    );
  }

//function of totdo
  Future<void> createTodo({
    required String name,
    required String decrption,
  }) async {
    final auth = FirebaseAuth.instance;
    final userId = auth.currentUser!.uid;
    var uuid = const Uuid(); //3
    var todoId = uuid.v4(); //4
    try {
      await todoRef.doc(todoId).set({
        //5
        'todoName': name,
        'Decrption': decrption,
        'userid': userId,
        'todoId': todoId,
      });
    } catch (e) {}
  }

  Future<void> updateTodo(
      {required String todoName, required String Decrption}) async {
    try {
      await todoRef
          .doc(Id)
          .update({'todoName': todoName, 'Decrption': Decrption});
    } catch (e) {}
  }
}
