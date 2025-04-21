import 'package:auto_route/auto_route.dart';
import 'package:business_manager/core/helpers/date_format_helper.dart';
import 'package:business_manager/core/supabase/supabase_config.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/buttons/primary_button/primary_button.dart';
import 'package:business_manager/core/widgets/buttons/secondary_button/secondary_button.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/core/widgets/custom_dialog/custom_dialog.dart';
import 'package:business_manager/core/widgets/layouts/bg_linear_container/bg_linear_container.dart';
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
      body: BgLinearContainer(
        colors: const [
          // Pallete.gradient1,
          Colors.blueAccent,
          Pallete.colorOne,
          // Colors.blueAccent,
          Colors.lightBlue
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
                  // color: Pallete.colorOne,
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Constants.padding32),
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
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "${context.strings.profile_email_label}:\n",
                                  style: context.text.bodyMedium?.copyWith(
                                    color: Pallete.colorFour,
                                  ),
                                ),
                                TextSpan(
                                  text: _user?.email ??
                                      context.strings.profile_email_placeholder,
                                  style: context.text.bodyMedium?.copyWith(
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          const SizedBox(height: 8),
                          RichText(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "${context.strings.profile_user_created_at}:\n",
                                  style: context.text.bodyMedium?.copyWith(
                                    color: Pallete.colorFour,
                                  ),
                                ),
                                TextSpan(
                                  text: DateFormatHelper.dateFormatFromString(
                                      _user?.createdAt),
                                  style: context.text.bodyMedium?.copyWith(
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          )
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
              const SizedBox(height: Constants.padding46),
              PrimaryButton(
                onPressed: _launchURL,
                buttonText: context.strings.profile_button_reset_password,
                shadowColor: Colors.green,
              ),
              const SizedBox(height: Constants.padding46),
              SecondaryButton(
                onPressed: () => _showReinitConfirmationDialog(context),
                buttonText: 'Delete Your account',
                backgroundColor: Colors.red,
                shadowColor: Colors.white,
              ),
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

  Future<void> _deleteSupabaseUserAccount(BuildContext context) async {
    try {
      await Supabase.initialize(
        url: SupabaseConfig.supabaseUrl,
        anonKey: SupabaseConfig.supabaseAnonKey,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your Supabase Account was Deleted.')),
      );
      setState(() {
        _user = Supabase.instance.client.auth.currentUser;
      });
      context.router.popUntilRoot();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete Supabase Account: $e')),
      );
    }
  }

  void _showReinitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: "Delete User Account",
        question: "Are you sure you want to ",
        currentItem: "Delete  ",
        itemType: "your Account?",
        confirmText: "Delete",
        cancelText: "Cancel",
        onConfirm: () => _deleteSupabaseUserAccount(context),
      ),
    );
  }
}
