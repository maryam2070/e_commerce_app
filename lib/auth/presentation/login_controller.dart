import 'package:e_commerce_app/auth/domain/usecases/login_use_case.dart';
import 'package:flutter/cupertino.dart';

class LoginController with ChangeNotifier {
  LoginUseCase loginUseCase;
  String email;
  String password;
  bool success;
  bool isError;
  String errorMessage;

  LoginController(
      {required this.loginUseCase,
      this.email = '',
      this.password = '',
      this.success = false,
      this.errorMessage = "",
      this.isError = false});

  void copyWith(
      {String? email,
      String? password,
      String? errorMessage,
      bool? success,
      bool? isError}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.errorMessage = errorMessage ?? this.errorMessage;
    this.success = success ?? this.success;
    this.isError = isError ?? this.isError;
    notifyListeners();
  }

  dynamic submit() async {
    final response = await loginUseCase.call(email, password);
    response.fold((failure) => {copyWith(errorMessage: failure.message)},
        (success) => {copyWith(success: true)});
  }

  void updateEmail(String email) => copyWith(email: email);

  void updatePassword(String password) => copyWith(password: password);
}
