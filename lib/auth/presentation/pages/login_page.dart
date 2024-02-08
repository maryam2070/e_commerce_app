import 'package:e_commerce_app/auth/data/repositories/auth_repository_impl.dart';
import 'package:e_commerce_app/auth/domain/usecases/login_use_case.dart';
import 'package:e_commerce_app/auth/presentation/login_controller.dart';
import 'package:e_commerce_app/auth/presentation/widgets/main_button.dart';
import 'package:e_commerce_app/auth/presentation/widgets/social_account_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utilities/routes.dart';
import '../../data/data_sources/auth_data_source.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    //todo injection

    return Provider<LoginUseCase>(
      create: (_) => LoginUseCase(
          repository: AuthRepositoryImpl(ds: AuthDataSourceImpl(null))),
      child: const LoginPage(),
    );
  }
}

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
    final login = Provider.of<LoginUseCase>(context);

    return ChangeNotifierProvider<LoginController>(
      create: (_) => LoginController(loginUseCase: login),
      child: Consumer<LoginController>(
        builder: (_, model, __) {
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
                          onChanged: model.updateEmail,
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
                              labelText: "Email",
                              hintText: 'Enter your email')),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          onChanged: model.updatePassword,
                          focusNode: _passwordFocusNode,
                          controller: _passwordController,
                          validator: (val) => val!.isEmpty
                              ? 'Please enter your password'
                              : null,
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
                              debugPrint(model.email);
                              debugPrint(model.password);
                              //todo login
                              //model.submit();
                              if (model.success) {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.navRoute);
                              }

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
                            Navigator.of(context)
                                .pushNamed(AppRoutes.signupRoute);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
