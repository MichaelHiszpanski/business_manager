import 'package:auto_route/auto_route.dart';
import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/core/widgets/layouts/bg_sweep_container/bg_sweep_container.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/scheduler.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with WidgetsBindingObserver {
  late final dynamic _user;

  @override
  void initState() {
    super.initState();
    _user = Supabase.instance.client.auth.currentUser;
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
        title: context.strings.profile_name,
        onMenuPressed: () {},
        titleFontColor: Colors.white,
        iconArrowColor: Colors.white,
      ),
      body: BgSweepContainer(
        colors: const [
          Pallete.gradient1,
          Colors.white,
          Colors.red,
          Colors.green,
          Colors.blue
        ],
        child: Padding(
          padding: const EdgeInsets.all(Constants.padding16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                context.strings.profile_name,
                style: context.text.headlineLarge?.copyWith(
                  color: Pallete.colorOne,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Constants.padding32 * 4),
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
                            "${context.strings.profile_email_label}: "
                            "${_user?.email ?? context.strings.profile_email_placeholder}",
                            style: context.text.bodyMedium?.copyWith(
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${context.strings.profile_user_id_label}:"
                            "${_user?.id ?? context.strings.profile_email_placeholder}",
                            style: context.text.bodyMedium?.copyWith(
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${context.strings.profile_user_created_at}:"
                            "${DateFormatHelper.dateFormatFromString(_user?.createdAt)}",
                            style: context.text.bodyMedium?.copyWith(
                              color: Colors.black87,
                            ),
                            maxLines: 3,
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          context.strings.profile_no_user_message,
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
                      context.strings.profile_password_reset_instruction,
                      style: context.text.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                    Text(
                      context.strings.profile_go_to_website_message,
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
                    context.strings.profile_button_reset_password,
                    style: context.text.displaySmall,
                  ),
                ),
              ),
              const SizedBox(height: Constants.padding16 * 4),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
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
}
