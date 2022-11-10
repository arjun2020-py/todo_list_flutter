// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/Login/view/login_page.dart';

class SiginupPage extends StatefulWidget {
  SiginupPage({super.key});

  @override
  State<SiginupPage> createState() => _SiginupPageState();
}

class _SiginupPageState extends State<SiginupPage> {
  TextEditingController emailController = TextEditingController(),
      passwrodController = TextEditingController(),
      usernameController = TextEditingController(),
      mobilenoController = TextEditingController();

  final fromkey = GlobalKey<FormState>();

  void validateTextfield() {
    if (fromkey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: fromkey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Lottie.asset("assets/images/107800-login-leady.json",
                      height: 250),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'SIGINUP',
                    style: TextStyle(
                        color: Color(0xff0097a7),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      // ignore: prefer_single_quotes
                      hintText: "Username",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[A-Za-z][A-Za-z0-9_]{7,29}$')
                              .hasMatch(value) ||
                          value.length <= 4) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      // ignore: prefer_single_quotes
                      hintText: "EmailId",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty || // 'r' indicate row string
                          !RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                              .hasMatch(value)) {
                        return 'Please Enter vaild email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: mobilenoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      // ignore: prefer_single_quotes
                      hintText: "MobileNo",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
                              .hasMatch(value)) {
                        return 'Please enter vaild mobile number';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwrodController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      // ignore: prefer_single_quotes
                      hintText: "Passwrod",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required';
                      } else if (value.length < 6) {
                        return 'Should be atleast 6 charcaters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (fromkey.currentState!.validate()) {
                          createUser(
                              emailController.text,
                              passwrodController.text,
                              usernameController.text,
                              mobilenoController.text,
                              context);
                        }

                        child:
                        const Text('Siginup');
                      },
                      //  child: null,
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff095259),
                        side: const BorderSide(width: 3, color: Colors.white),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text("Siginup"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account ?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'Login');
                        },
                        child: const Text('Login'),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> createUser(String email, String password, String username,
    String mobile, BuildContext context) async {
  final auth = FirebaseAuth.instance;
  final userRef = FirebaseFirestore.instance.collection('users');
  try {
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userRef.doc(auth.currentUser!.uid).set({
      //userRef.doc(auth.currentUser!.uid).set get crosspoding image
      'userid': auth.currentUser!.uid,
      'userName': username,
      'email': email,
      'mobile': mobile,
      'password': password,
      'profileImage': '',
    });
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  } on FirebaseAuthException catch (e) {
    print(e.code);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code)));
  }
}
