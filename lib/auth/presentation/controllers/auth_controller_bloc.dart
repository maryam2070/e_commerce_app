import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/auth/domain/usecases/login_use_case.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/forgot_password_use_case.dart';
import '../../domain/usecases/google_signin_use_case.dart';
import '../../domain/usecases/sign_up_use_case.dart';

part 'auth_controller_event.dart';

part 'auth_controller_state.dart';

class AuthControllerBloc
    extends Bloc<AuthControllerEvent, AuthControllerState> {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;
  final GoogleSignInUseCase googleSignInUseCase;

  final ForgotPasswordUseCase forgotPasswordUseCase;

  AuthControllerBloc(
      {required this.signUpUseCase,
      required this.loginUseCase,
      required this.googleSignInUseCase,
      required this.forgotPasswordUseCase})
      : super(AuthControllerInitial()) {
    on<AuthControllerEvent>((event, emit) async {
      if (event is SignUpEvent) {
        emit(AuthControllerLoading());
        final call =
            await signUpUseCase.call(event.email, event.password, event.data);

        call.fold((l) {
          emit(AuthControllerError(message: l.message));
        }, (r) {
          emit(AuthControllerSuccess());
        });
      }
      if (event is LoginEvent) {
        emit(AuthControllerLoading());
        final call = await loginUseCase.call(event.email, event.password);

        call.fold((l) {
          emit(AuthControllerError(message: l.message));
        }, (r) {
          emit(AuthControllerSuccess());
        });
      }
      if (event is GoogleSignInEvent) {
        emit(AuthControllerLoading());
        final call = await googleSignInUseCase.call();
        call.fold((l) {
          emit(AuthControllerError(message: l.message));
        }, (r) {
          emit(AuthControllerSuccess());
        });
      }

      if (event is ForgotPasswordEvent) {
        emit(AuthControllerLoading());
        final call = await forgotPasswordUseCase.call(event.email);
        call.fold((l) {
          emit(AuthControllerError(message: l.message));
        }, (r) {
          emit(AuthControllerSuccess());
        });
      }
    });
  }
}
