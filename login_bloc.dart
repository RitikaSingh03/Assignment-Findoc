import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/validators.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(
        email: event.email,
        isValidEmail: Validators.isValidEmail(event.email),
      ));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
        password: event.password,
        isValidPassword: Validators.isValidPassword(event.password),
      ));
    });

    on<LoginSubmitted>((event, emit) async {
      final validEmail = Validators.isValidEmail(state.email);
      final validPassword = Validators.isValidPassword(state.password);
      if (validEmail && validPassword) {
        emit(state.copyWith(isSubmitting: true, isFailure: false));
        await Future.delayed(const Duration(seconds: 1)); // mock API
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copyWith(
          isFailure: true,
          isValidEmail: validEmail,
          isValidPassword: validPassword,
        ));
      }
    });
  }
}
