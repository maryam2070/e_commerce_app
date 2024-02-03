import 'package:e_commerce_app/auth/presentation/widgets/main_button.dart';
import 'package:e_commerce_app/auth/presentation/widgets/social_account_row.dart';
import 'package:e_commerce_app/utilities/routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  //final emailController:Controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Login",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
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
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: const Text("Forgot your password?"),
                    onTap: () {
                      //todo navigate to forgot password
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                MainButton(
                    ontap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushNamed(AppRoutes.navRoute);
                        //todo login
                      }
                    },
                    text: "Login"),
                const SizedBox(
                  height: 80,
                ),
                const SocialAccountsRow(title: "Or login with"),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    child: const Text("New? Sign Up "),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.signupRoute);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
