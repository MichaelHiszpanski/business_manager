import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/main_utils/main_bloc/main_bloc.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/core/widgets/outlined_text_field/outlined_text_field.dart';
import 'package:business_manager/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _launchURL() async {
    final Uri url =
        Uri.parse("https://business-manager-website.vercel.app/sign-up");
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.strings.sign_in,
        onMenuPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.padding16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedTextField(
              labelText: context.strings.email,
              hintText: context.strings.enter_emial,
              inputValue: _emailController,
            ),
            const SizedBox(height: Constants.padding16),
            OutlinedTextField(
              labelText: context.strings.password,
              hintText: context.strings.enter_password,
              inputValue: _passwordController,
            ),
            const SizedBox(height: Constants.padding16),
            Container(
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () async => await _signInWithEmailAndPassword(),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Pallete.gradient1),
                ),
                child: Text(
                  context.strings.sign_in_with_email,
                  style: const TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: Constants.padding16),
            Container(
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Constants.radius10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _launchURL,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Pallete.gradient3),
                ),
                child: Text(
                  context.strings.sign_up,
                  style: const TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: Constants.padding16),
          ],
        ),
      ),
    );
  }
}
