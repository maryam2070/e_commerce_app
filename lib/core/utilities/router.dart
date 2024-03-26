import 'package:e_commerce_app/auth/presentation/pages/forgot_password_page.dart';
import 'package:e_commerce_app/auth/presentation/pages/landing_page.dart';
import 'package:e_commerce_app/auth/presentation/pages/login_page.dart';
import 'package:e_commerce_app/auth/presentation/pages/sign_up_page.dart';
import 'package:e_commerce_app/core/utilities/routes.dart';
import 'package:flutter/cupertino.dart';
import '../../product/domain/models/product.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/product_details_page.dart';
import '../presentation/widgets/persistent_bottom_nav_bar.dart';

Route<dynamic> onGenerate(RouteSettings st) {
  switch (st.name) {
    case AppRoutes.loginRoute:
      return CupertinoPageRoute(builder: (_) => LoginPage(), settings: st);

    case AppRoutes.signupRoute:
      return CupertinoPageRoute(
          builder: (_) => const SignUpPage(), settings: st);

    case AppRoutes.forgotPasswordRoute:
      return CupertinoPageRoute(
          builder: (_) => const ForgotPasswordPage(), settings: st);

    case AppRoutes.homeRoute:
      return CupertinoPageRoute(builder: (_) => const HomePage(), settings: st);

    case AppRoutes.navRoute:
      return CupertinoPageRoute(
          builder: (_) => const BottomNavigationBar(), settings: st);

    case AppRoutes.productDetailsRoute:
      {
        final product = st.arguments as Product;
        return CupertinoPageRoute(
            builder: (_) => ProductDetails(product: product), settings: st);
      }

    default:
      return CupertinoPageRoute(
          builder: (_) => const LandingPage(), settings: st);
  }
}
