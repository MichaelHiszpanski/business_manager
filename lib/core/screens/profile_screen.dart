import 'package:auto_route/auto_route.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/core/widgets/layouts/height_layout.dart';
import 'package:business_manager/feature/auth/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final dynamic _user;

  @override
  void initState() {
    super.initState();
    _user = Supabase.instance.client.auth.currentUser;
  }

  Future<void> _launchURL() async {
    final Uri url =
        Uri.parse("https://business-manager-website.vercel.app/reset-password");
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
        title: "Profile",
        onMenuPressed: () {},
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/signin1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          HeightLayout(
              childWidget: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                "Profile",
                style: context.text.headlineLarge?.copyWith(
                  color: Pallete.gradient1,
                  fontSize: 36,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: Constants.padding16 * 5),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(Constants.padding16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Constants.radius10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: _user != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email: ${_user?.email ?? 'N/A'}",
                            style: context.text.bodyMedium?.copyWith(
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "User ID: ${_user?.id ?? 'N/A'}",
                            style: context.text.bodyMedium?.copyWith(
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Created At: ${_user?.createdAt ?? 'N/A'}",
                            style: context.text.bodyMedium?.copyWith(
                              color: Colors.black87,
                            ),
                            maxLines: 3,
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          "No user logged in.",
                          style: context.text.bodyMedium?.copyWith(
                            color: Colors.black87,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: Constants.padding16 * 4),
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
                      "To restart your password",
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
                    backgroundColor: WidgetStateProperty.all(Pallete.gradient1),
                  ),
                  child: Text(
                    "Reset Password",
                    style: context.text.displaySmall,
                  ),
                ),
              ),
              const SizedBox(height: Constants.padding16*4),
              const Spacer(),
            ],
          ))
        ],
      ),
    );
  }
}
