import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'autincation_event.dart';
part 'autincation_state.dart';

class AutincationBloc extends Bloc<AutincationEvent, AutincationState> {
  AutincationBloc() : super(AutincationInitial()) {
    on<AutincationEvent>((event, emit) async {
      //6
      if (event is LoginEvent) {
        final auth = FirebaseAuth.instance;

        //7
        try {
          await auth.signInWithEmailAndPassword(
            email: event.email,
            password: event.passwrod,
          );
          //8
          emit(LoginSucess());
        } on FirebaseAuthException catch (e) {
          //9
          emit(LoginFailed(mesage: e.code));
        }
      }
    });
  }
}

 // onPressed: () async {
                        //   validateTextfield();
                        //   //cerate objrct of fireabse authication
                        //   final auth = FirebaseAuth.instance;
                        //   try {
                        //     await auth.signInWithEmailAndPassword(
                        //       email: emailController.text,
                        //       password: passwrodController.text,
                        //     );
                        //     Navigator.pushNamed(context, 'Home');
                        //   } on FirebaseAuthException catch (e) {
                        //     ScaffoldMessenger.of(context)
                        //         .showSnackBar(SnackBar(content: Text(e.code)));
                        //     print(e.code);
                        //     print("Login fileld");
                        //   }
                        // },
