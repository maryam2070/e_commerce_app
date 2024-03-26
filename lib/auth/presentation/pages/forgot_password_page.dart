import 'package:e_commerce_app/auth/presentation/controllers/auth_controller_bloc.dart';
import 'package:e_commerce_app/auth/presentation/widgets/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _emailController=TextEditingController();
    final _key=GlobalKey<FormState>();
    final size=MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height*.1,
              ),
              Text("Forgot Password",style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold
              )),
              SizedBox(
                height: size.height*.1,
              ),
              Text("Please, enter your email address. You will receive a link to create a new password via email.",
                  style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(
                height: size.height*.05,
              ),
              TextFormField(
                  controller: _emailController,
                  validator: (val) =>
                  val!.isEmpty ? 'Please enter your email' : null,
                  decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: 'Enter your email')),
              SizedBox(
                height: size.height*.05,
              ),
              MainButton(ontap: (){
                if (_key.currentState!.validate()) {
                  BlocProvider.of<AuthControllerBloc>(context).add(ForgotPasswordEvent(email: _emailController.text));
                }
              }, text: "Send")
            ],
          ),
        ),
      ),
    );
  }
}
