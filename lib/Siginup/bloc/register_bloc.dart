import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      final auth = FirebaseAuth.instance;
      final userRef = FirebaseFirestore.instance.collection('users');

      if (event is SiginupEvent) {
        try {
          await auth.createUserWithEmailAndPassword(
            email: event.Email,
            password: event.Passwrod,
          );

          await userRef.doc(auth.currentUser!.uid).set({
            'userid': auth.currentUser!.uid,
            'userName': event.userName,
            'email': event.Email,
            'mobile': event.MobNo,
            'password': event.Passwrod,
            'profileImage': '',
          });
          emit(SignUpSuccess());
        } on FirebaseAuthException catch (e) {
          emit(SignupFailed(errMessage: e.code));
        }
      }
    });
  }
}

   
// Future<void> createUser(String email, String password, String username,
//     String mobile, BuildContext context) async {
//   final auth = FirebaseAuth.instance;
//   final userRef = FirebaseFirestore.instance.collection('users');
//   try {
//     await auth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     await userRef.doc(auth.currentUser!.uid).set({
//       //userRef.doc(auth.currentUser!.uid).set get crosspoding image
//       'userid': auth.currentUser!.uid,
//       'userName': username,
//       'email': email,
//       'mobile': mobile,
//       'password': password,
//       'profileImage': '',
//     });
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => LoginPage(),
//         ));
//   } on FirebaseAuthException catch (e) {
//     print(e.code);
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code)));
//   }
// }
