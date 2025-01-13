import 'package:auto_route/annotations.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;


  Future<void> _signInWithSupabase() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {

        setState(() {
          _errorMessage = "Failed to sign in. Please check your credentials.";
        });
        return;
      }

      final authToken = Supabase.instance.client.auth.currentSession?.accessToken;

      if (authToken != null && mounted) {
        context.read<MainBloc>().add(UpdateAuthToken(authToken: authToken));
        MainApp.navigatorKey.currentState!.pushNamedAndRemoveUntil(
          AppRoutes.homePage,
              (Route<dynamic> route) => false,
        );
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error signing in with Supabase: $error');
      }
      setState(() {
        _errorMessage = error.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
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

                onPressed: _isLoading ? null : _signInWithSupabase,
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
