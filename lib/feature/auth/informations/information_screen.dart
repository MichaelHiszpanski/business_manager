import 'package:auto_route/auto_route.dart';
import 'package:business_manager/core/theme/app_font_family.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/app_properties.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/buttons/primary_button/primary_button.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/core/widgets/layouts/center_column_layout/center_column_layout.dart';
import 'package:business_manager/feature/auth/informations/widgets/informations_screen_row.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class InformationsScreen extends StatefulWidget {
  const InformationsScreen({super.key});

  @override
  State<InformationsScreen> createState() => _InformationsScreenState();
}

class _InformationsScreenState extends State<InformationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: context.strings.title_info,
        onMenuPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Pallete.colorSix.withOpacity(0.5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.padding16,
              vertical: Constants.padding24,
            ),
            child: CenterColumnLayout(
              children: [
                const SizedBox(height:  Constants.padding46),
                Text(
                  context.strings.app_name,
                  style: context.text.titleLarge
                      ?.copyWith(color: Colors.blueAccent),
                ),
                const SizedBox(height: Constants.padding24),
                Text(
                  context.strings.app_description,
                  style: context.text.displaySmall?.copyWith(
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: Constants.padding24),
                Text(context.strings.key_features_title,
                    style: context.text.titleMedium?.copyWith(
                      fontFamily: AppFontFamily.orbitron,
                      color: Colors.black87,
                    )),
                const SizedBox(height: Constants.padding24),
                InformationScreenRow(
                  icon: Icons.checklist,
                  title: context.strings.feature_todo_list_title,
                  description: context.strings.feature_todo_list_description,
                ),
                InformationScreenRow(
                  icon: Icons.receipt_long,
                  title: context.strings.feature_invoice_manager_title,
                  description:
                      context.strings.feature_invoice_manager_description,
                ),
                InformationScreenRow(
                  icon: Icons.calendar_today,
                  title: context.strings.feature_work_manager_title,
                  description: context.strings.feature_work_manager_description,
                ),
                InformationScreenRow(
                  icon: Icons.people,
                  title: context.strings.feature_employee_management_title,
                  description:
                      context.strings.feature_employee_management_description,
                ),
                const SizedBox(height: 3 * Constants.padding16),
                PrimaryButton(
                  onPressed: _launchURL,
                  buttonText: context.strings.button_open_website,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(AppProperties.websiteUrlHomePage);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
