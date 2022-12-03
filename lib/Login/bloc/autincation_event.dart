part of 'autincation_bloc.dart';

@immutable
abstract class AutincationEvent {}

class LoginEvent extends AutincationEvent {
  //5

  LoginEvent({required this.email, required this.passwrod});
  String email;
  String passwrod;
}
