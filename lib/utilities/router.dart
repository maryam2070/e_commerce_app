import 'package:e_commerce_app/auth/presentation/pages/login_page.dart';
import 'package:e_commerce_app/auth/presentation/pages/sign_up_page.dart';
import 'package:e_commerce_app/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/utilities/routes.dart';
import 'package:flutter/cupertino.dart';

import '../presentation/pages/landing_page.dart';

Route<dynamic> onGenerate(RouteSettings st) {
  switch (st.name) {
    case AppRoutes.loginRoute:
      return CupertinoPageRoute(
          builder: (_) => const LoginPage(), settings: st);

    case AppRoutes.signupRoute:
      return CupertinoPageRoute(
          builder: (_) => const SignUpPage(), settings: st);

    case AppRoutes.homeRoute:
      return CupertinoPageRoute(builder: (_) => const HomePage(), settings: st);
    default:
      return CupertinoPageRoute(
          builder: (_) => const LandingPage(), settings: st);
  }
}
