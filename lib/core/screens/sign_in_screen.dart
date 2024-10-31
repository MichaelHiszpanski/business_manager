import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/main_utils/main_bloc/main_bloc.dart';
import 'package:business_manager/core/widgets/outlined_text_field/outlined_text_field.dart';
import 'package:business_manager/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final User? user = userCredential.user;

      if (user != null) {
        String? authToken = await user.getIdToken();

        if (mounted) {
          context
              .read<MainBloc>()
              .add(UpdateAuthToken(authToken: authToken ?? ""));

          MainApp.navigatorKey.currentState!.pushNamedAndRemoveUntil(
            AppRoutes.homePage,
            (Route<dynamic> route) => false,
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error SignIn with Email and Password: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign-In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedTextField(
              labelText: "Email",
              hintText: "Enter Email",
              inputvalue: _emailController,
            ),
            const SizedBox(height: 16),
            OutlinedTextField(
              labelText: "Password",
              hintText: "Enter Password",
              inputvalue: _passwordController,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async => await _signInWithEmailAndPassword(),
              child:const Text("Sign in with Email"),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
