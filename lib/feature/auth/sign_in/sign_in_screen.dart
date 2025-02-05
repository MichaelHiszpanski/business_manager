import 'package:auto_route/annotations.dart';
import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/main_utils/main_bloc/main_bloc.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/tools/network_controler.dart';
import 'package:business_manager/core/widgets/buttons/button_wrappers/button_wrapper_one.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/core/widgets/layouts/height_layout.dart';
import 'package:business_manager/core/widgets/outlined_text_field/outlined_text_field.dart';
import 'package:business_manager/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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

      final authToken =
          Supabase.instance.client.auth.currentSession?.accessToken;

      if (authToken != null && mounted) {
        context.read<MainBloc>().add(UpdateAuthToken(authToken: authToken));
        MainApp.navigatorKey.currentState!.pushNamedAndRemoveUntil(
          AppRoutes.homePage,
          (Route<dynamic> route) => false,
        );
      }
    } catch (error) {
      setState(() {
        _errorMessage = "Failed to sign in. Please check your credentials.";
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/signin2.png',
              fit: BoxFit.cover,
            ),
          ),
          HeightLayout(
            childWidget: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Spacer(),
                if (_errorMessage != null && _errorMessage != "") ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(Constants.padding4),
                    decoration: const BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Constants.radius25),
                      ),
                    ),
                    child: Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: context.text.bodyLarge?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: Constants.padding16),
                Text(
                  "Business Manager",
                  style: context.text.headlineMedium?.copyWith(),
                ),
                const SizedBox(height: Constants.padding16),
                Text(
                  "Sign-In",
                  style: context.text.headlineLarge?.copyWith(
                    color: Pallete.gradient1,
                  ),
                ),
                const SizedBox(height: Constants.padding16 * 3),
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
                const SizedBox(height: Constants.padding16 * 4),
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
                  child: ButtonWrapperOne(
                    child: Obx(
                      () => ElevatedButton(
                        onPressed:
                            (_isLoading || !NetworkController.isNetworkConnected.value)
                                ? null
                                : _signInWithSupabase,
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          context.strings.sign_in_with_email,
                          style: context.text.displayMedium,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Constants.padding16 * 2),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(Constants.padding4),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(Constants.radius25),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "You don`t have an account?",
                        style: context.text.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                      Text(
                        "Go to website and ...",
                        style: context.text.bodyLarge?.copyWith(
                          color: Pallete.gradient1,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ],
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
                        spreadRadius: 3,
                        blurRadius: 6,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _launchURL,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Pallete.gradient1),
                    ),
                    child: Text(
                      context.strings.sign_up,
                      style: context.text.displayMedium,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
