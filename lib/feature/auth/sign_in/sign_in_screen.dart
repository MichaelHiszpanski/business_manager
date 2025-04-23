import 'package:auto_route/annotations.dart';
import 'package:business_manager/core/main_utils/app_routes/app_routes.dart';
import 'package:business_manager/core/main_utils/main_bloc/main_bloc.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/app_properties.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/tools/network_controler.dart';
import 'package:business_manager/core/widgets/buttons/primary_button/primary_button.dart';
import 'package:business_manager/core/widgets/buttons/secondary_button/secondary_button.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/core/widgets/layouts/bg_linear_container/bg_linear_container.dart';
import 'package:business_manager/core/widgets/layouts/center_column_layout/center_column_layout.dart';
import 'package:business_manager/core/widgets/outlined_text_field/outlined_text_field.dart';
import 'package:business_manager/main.dart';
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

class _SignInScreenState extends State<SignInScreen>
    with WidgetsBindingObserver {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: context.strings.sign_in,
        onMenuPressed: () {},
        titleFontColor: Pallete.colorOne,
      ),
      body: BgLinearContainer(
        colors: const [
          Colors.black,
          Pallete.colorSix,
          Pallete.colorSeven,
          Pallete.gradient1,
        ],
        child: CenterColumnLayout(
          children: [
            const SizedBox(height: Constants.padding32),
            if (_errorMessage != null && _errorMessage != "") ...[
              const SizedBox(height: Constants.padding32),
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
                    fontSize: 16,
                  ),
                ),
              ),
            ],
            const SizedBox(height: Constants.padding16),
            Text(
              context.strings.app_name,
              style: context.text.headlineMedium?.copyWith(),
            ),
            const SizedBox(height: Constants.padding16),
            Text(
              context.strings.sign_in,
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
              isPassword: true,
            ),
            const SizedBox(height: Constants.padding16 * 4),
            PrimaryButton(
              onPressed: () =>
                  (_isLoading || !NetworkController.isNetworkConnected.value)
                      ? null
                      : _signInWithSupabase(),
              buttonText: context.strings.sign_in_with_email,
              shadowColor: Colors.black87,
              customStyle:
                  context.text.displayMedium?.copyWith(color: Pallete.colorOne),
            ),
            const SizedBox(height: Constants.padding46),
            SecondaryButton(
              onPressed: _launchURL,
              buttonText: context.strings.sign_up,
              shadowColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

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
          _errorMessage = context.strings.sign_in_error_sign_in_failed;
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
        _errorMessage = context.strings.sign_in_error_sign_in_failed;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(AppProperties.websiteUrlSignUpPage);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
