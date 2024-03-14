import 'package:e_commerce_app/auth/presentation/controllers/auth_controller_bloc.dart';
import 'package:e_commerce_app/auth/presentation/widgets/main_button.dart';
import 'package:e_commerce_app/auth/presentation/widgets/social_account_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/utilities/routes.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _emailFocusNode = FocusNode();
    final _passwordFocusNode = FocusNode();
    final _nameFocusNode = FocusNode();
    _nameController.text="maryam";
    _emailController.text="maryamamr2070@gmail.com";
    _passwordController.text="123456789";
    return BlocBuilder<AuthControllerBloc, AuthControllerState>(
      builder: (context, state) {
        if(state is AuthControllerSuccess){
          Navigator.of(context).popAndPushNamed(
              AppRoutes.navRoute);
        }
        if(state is AuthControllerError){
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        return Stack(
          alignment: Alignment.center,
          children:[
            (state is AuthControllerLoading)?
            CircularProgressIndicator(
              color: Colors.redAccent,
            ):Container(),
            Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          "Sign Up",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        TextFormField(
                            controller: _nameController,
                            focusNode: _nameFocusNode,
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(_emailFocusNode);
                            },
                            textInputAction: TextInputAction.next,
                            validator: (val) =>
                            val!.isEmpty ? 'Please enter your name' : null,
                            decoration: const InputDecoration(
                                labelText: "Name", hintText: 'Enter your name')),
                        Container(
                          decoration: BoxDecoration(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                            textInputAction: TextInputAction.next,
                            validator: (val) =>
                            val!.isEmpty ? 'Please enter your email' : null,
                            decoration: const InputDecoration(
                                labelText: "Email", hintText: 'Enter your email')),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            focusNode: _passwordFocusNode,
                            controller: _passwordController,
                            validator: (val) =>
                            val!.isEmpty ? 'Please enter your password' : null,
                            decoration: const InputDecoration(
                                labelText: "Password",
                                hintText: 'Enter your password')),
                        const SizedBox(
                          height: 50,
                        ),
                        MainButton(
                            ontap: () {
                              if (_formKey.currentState!.validate()) {

                                BlocProvider.of<AuthControllerBloc>(context).add(
                                    SignUpEvent(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        data: Map()));

                              }
                            },
                            text: "Sign up"),
                        const SizedBox(
                          height: 80,
                        ),
                        const SocialAccountsRow(title: "Or Sign up with")
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
