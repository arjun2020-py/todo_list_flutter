// ignore_for_file: non_constant_identifier_names

part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

// ignore: must_be_immutable
class SiginupEvent extends RegisterEvent {
  // ignore: lines_longer_than_80_chars
  SiginupEvent(
      {required this.userName,
      required this.Email,
      required this.MobNo,
      required this.Passwrod});


  String userName;
  String Email;
  String MobNo;
  String Passwrod;
}
