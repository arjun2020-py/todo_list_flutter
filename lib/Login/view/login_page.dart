// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion_toast/motion_toast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwrodController = TextEditingController();

  final fromkey =
      GlobalKey<FormState>(); //key tell about change of state in textfromfield.
  // This uniquely identifies the Form, and allows validation of the form in a later step.

  void validateTextfield() {
    if (fromkey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      // MotionToast(
      //   icon: Icons.done,
      //   description: Text("Login successfully"),
      //   primaryColor: Colors.greenAccent,
      // ).show(context);
    } else {
      // MotionToast(
      //   icon: Icons.error,
      //   description: Text("Invalid Login"),
      //   primaryColor: Colors.redAccent,
      // ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: fromkey,
          child: ListView(
            // ignore: prefer_int_literals
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Image.asset(
                    'assets/images/login1-modified.png',
                    height: 250,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0097a7),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty || // 'r' indicate row string
                          !RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                              .hasMatch(value)) {
                        return "Please Enter vaild email address";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwrodController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Passwrod',
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
                    height: 20,
                  ),
                ],
              ),
              Column(
                // ignore: lines_longer_than_80_chars, lines_longer_than_80_chars
                children: [
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        validateTextfield();
                        //cerate objrct of fireabse authication
                        final auth = FirebaseAuth.instance;
                        try {
                          await auth.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwrodController.text,
                          );
                          Navigator.pushNamed(context, 'Home');
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e.code)));
                          print(e.code);
                          print("Login fileld");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff095259),
                        side: const BorderSide(width: 3, color: Colors.white),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Passwrod ?'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed('Siginup'),
                    child: const Text('Create an Account ?'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 20),
                          child: const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                      ),
                      const Text('OR'),
                      Expanded(
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 10),
                          child: const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.facebook_outlined),
                        color: Colors.blueAccent,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.twitter),
                        color: Colors.blueAccent,
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
