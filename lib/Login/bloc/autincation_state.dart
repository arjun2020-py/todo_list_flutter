part of 'autincation_bloc.dart';

@immutable
abstract class AutincationState {}

class AutincationInitial extends AutincationState {}

class LoginSucess extends AutincationState {}

class LoginFailed extends AutincationState {
  //10

  LoginFailed({required this.mesage});

  String mesage;
}
