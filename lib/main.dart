import 'package:e_commerce_app/auth/domain/usecases/login_use_case.dart';
import 'package:e_commerce_app/product/di/product_di.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'auth/di/auth_di.dart';
import 'auth/domain/usecases/sign_up_use_case.dart';
import 'auth/presentation/controllers/auth_controller_bloc.dart';
import 'cart/di/cart_di.dart';
import 'core/presentation/controllers/cart_controller/cart_bloc.dart';
import 'core/presentation/controllers/home_controller/home_bloc.dart';
import 'core/utilities/router.dart';
import 'core/utilities/routes.dart';

import 'package:firebase_app_check/firebase_app_check.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );

  authSetup();
  productSetup();
  cartSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.I;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthControllerBloc(
              signUpUseCase: getIt.get<SignUpUseCase>(),
              loginUseCase: getIt.get<LoginUseCase>(),
              googleSignInUseCase: getIt.get(),
              forgotPasswordUseCase: getIt.get()),
        ),
        BlocProvider(
          create: (context) => HomeBloc(
            getNewProductListUseCase: getIt.get(),
            getSaleProductListUseCase: getIt.get(),
          )..add(HomeEvent()),
        ),
        BlocProvider(
            create: (context) => CartBloc(
                addToCartUseCase: getIt.get(),
                getCartUseCase: getIt.get(),
                deleteFromCartUseCase: getIt.get(),
                addOrderUseCase: getIt.get(),
                getOrdersUseCase: getIt.get(),
                cancelOrderUseCase: getIt.get())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomAppBarColor: Colors.white,
          colorScheme:
              ColorScheme.fromSeed(seedColor: Theme.of(context).primaryColor),
          iconTheme: const IconThemeData(color: Colors.black),
          scaffoldBackgroundColor: const Color(0xfff9f9f9),
          //primarySwatch:  MaterialColor(Colo,0xffDB3022, as Map<int, Color>),
          primaryColor: const Color(0xffDB3022),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Colors.red))),
        ),
        onGenerateRoute: onGenerate,
        initialRoute: AppRoutes.navRoute,
      ),
    );
  }
}
