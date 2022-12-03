part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class SignUpSuccess extends RegisterState {}

class SignupFailed extends RegisterState {
  SignupFailed({required this.errMessage});
  String errMessage;
}
