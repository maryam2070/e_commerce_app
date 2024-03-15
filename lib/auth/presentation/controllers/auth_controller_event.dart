part of 'auth_controller_bloc.dart';

@immutable
abstract class AuthControllerEvent {}

class SignUpEvent extends AuthControllerEvent {
  String email;
  String password;
  Map<String, dynamic> data;

  SignUpEvent(
      {required this.email, required this.password, required this.data});
}

class LoginEvent extends AuthControllerEvent {
  String email;
  String password;

  LoginEvent({required this.email, required this.password});
}

class GoogleSignInEvent extends AuthControllerEvent {

  GoogleSignInEvent();
}