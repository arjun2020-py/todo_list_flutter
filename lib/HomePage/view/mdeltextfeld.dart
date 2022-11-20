import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ModelTextfield extends StatelessWidget {
  ModelTextfield({
    Key? key,
  }) : super(key: key);

  //create a  controller for two textfiled

  TextEditingController todoNameController = TextEditingController(),
      todoDecrptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets, //2
      child: Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 280),
              child: Text(
                'Add Todo',
                style: TextStyle(
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
                  createTodo(
                    name: todoNameController.text,
                    decrption: todoDecrptionController.text,
                  );
                  Navigator.pop(context);
                },
                child: const Text('Save'),
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
    final todoRef = FirebaseFirestore.instance.collection('todo collection');
    final auth = FirebaseAuth.instance;
    final userId = auth.currentUser!.uid;
    var uuid = const Uuid(); //3
    var todoId = uuid.v4(); //4
    try {
      await todoRef.doc(todoId).set({
        //5
        'todoName': name,
        'Decrption': decrption,
        "userid": userId,
        "todoId": todoId,
      });
    } catch (e) {}
  }
}
