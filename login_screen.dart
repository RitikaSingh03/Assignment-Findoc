import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../../home/presentation/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          } else if (state.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please fix the errors and try again')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Login",
                      style: GoogleFonts.montserrat(
                          fontSize: 32, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 24),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return TextField(
                        key: const Key('email-field'),
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: const OutlineInputBorder(),
                          errorText: state.isValidEmail ? null : "Enter a valid email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) =>
                            context.read<LoginBloc>().add(EmailChanged(value)),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return TextField(
                        key: const Key('password-field'),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: const OutlineInputBorder(),
                          errorText: state.isValidPassword
                              ? null
                              : "Password must have 8+ chars, upper, lower, digit & symbol",
                        ),
                        onChanged: (value) =>
                            context.read<LoginBloc>().add(PasswordChanged(value)),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: state.isSubmitting
                              ? null
                              : () {
                                  context.read<LoginBloc>().add(LoginSubmitted());
                                },
                          child: state.isSubmitting
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text("Submit"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
