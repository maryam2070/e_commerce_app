import 'package:e_commerce_app/auth/presentation/pages/login_page.dart';
import 'package:e_commerce_app/auth/presentation/pages/sign_up_page.dart';
import 'package:e_commerce_app/auth/presentation/pages/landing_page.dart';
import 'package:e_commerce_app/home/presentation/pages/home_page.dart';
import 'package:e_commerce_app/utilities/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../shared/presentation/widgets/persistent_bottom_nav_bar.dart';


Route<dynamic> onGenerate(RouteSettings st) {
  switch (st.name) {
    case AppRoutes.loginRoute:
      return CupertinoPageRoute(
          builder: (_) => const Login(), settings: st);

    case AppRoutes.signupRoute:
      return CupertinoPageRoute(
          builder: (_) => const SignUpPage(), settings: st);

    case AppRoutes.homeRoute:
      return CupertinoPageRoute(builder: (_) => const HomePage(), settings: st);

    case AppRoutes.navRoute:
      return CupertinoPageRoute(builder: (_) => const BottomNavigationBar(), settings: st);
    default:
      return CupertinoPageRoute(
          builder: (_) => const LandingPage(), settings: st);
  }
}
