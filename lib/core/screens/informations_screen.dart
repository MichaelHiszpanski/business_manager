import 'package:auto_route/auto_route.dart';
import 'package:business_manager/core/theme/app_font_family.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/app_properties.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
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
      appBar: CustomAppBar(
        title: context.strings.title_info,
        onMenuPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Constants.padding16,
          vertical: Constants.padding24,
        ),
        child: Column(
          children: [
            Text(
              context.strings.app_name,
              style:
                  context.text.titleLarge?.copyWith(color: Colors.blueAccent),
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
                style: context.text.displaySmall?.copyWith(
                  fontFamily: AppFontFamily.orbitron,
                  color: Colors.black87,
                )),
            const SizedBox(height: Constants.padding24),
            _getRow(
              icon: Icons.checklist,
              title: context.strings.feature_todo_list_title,
              description: context.strings.feature_todo_list_description,
            ),
            _getRow(
              icon: Icons.receipt_long,
              title: context.strings.feature_invoice_manager_title,
              description: context.strings.feature_invoice_manager_description,
            ),
            _getRow(
              icon: Icons.calendar_today,
              title: context.strings.feature_work_manager_title,
              description: context.strings.feature_work_manager_description,
            ),
            _getRow(
              icon: Icons.people,
              title: context.strings.feature_employee_management_title,
              description:
                  context.strings.feature_employee_management_description,
            ),
            const SizedBox(height: 3 * Constants.padding16),
            Container(
              width: double.maxFinite,
              height: 40,
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
                  backgroundColor: WidgetStateProperty.all(Pallete.gradient1),
                ),
                child: Text(
                  context.strings.button_open_website,
                  style: context.text.headlineSmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
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

  Widget _getRow({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.padding8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.0,
            backgroundColor: Colors.blueAccent.withOpacity(0.1),
            child: Icon(
              icon,
              color: Colors.blueAccent,
              size: 28.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: AppFontFamily.orbitron,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
