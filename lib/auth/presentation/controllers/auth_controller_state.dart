part of 'auth_controller_bloc.dart';

@immutable
abstract class AuthControllerState {}

class AuthControllerInitial extends AuthControllerState {}

class AuthControllerLoading extends AuthControllerState {}
class AuthControllerError extends AuthControllerState {
  final String message;

  AuthControllerError({required this.message});
}
class AuthControllerSuccess extends AuthControllerState {}
