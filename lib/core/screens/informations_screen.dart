import 'package:auto_route/auto_route.dart';
import 'package:business_manager/core/theme/app_font_family.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
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
        title: "Information's",
        onMenuPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Constants.padding16,
          vertical: Constants.padding24,
        ),
        child: Column(
          children: [
            const Text(
              'Business Manager',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontFamily: AppFontFamily.orbitron,
              ),
            ),
            const SizedBox(height: Constants.padding24),
            Text(
              'Business manager is a tool that will allow you to save time and improve your activities on the way to success.',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[900],
                height: 1.5,
                fontFamily: AppFontFamily.suse
              ),
            ),
            const SizedBox(height: Constants.padding24),
            const Text(
              'Key Features:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontFamily: AppFontFamily.orbitron,
              ),
            ),
            const SizedBox(height: Constants.padding24),
            _getRow(
              icon: Icons.checklist,
              title: 'To-Do List',
              description: 'Organize and track your daily tasks.',
            ),
            _getRow(
              icon: Icons.receipt_long,
              title: 'Invoice Manager',
              description: 'Generate and manage invoices with ease.',
            ),
            _getRow(
              icon: Icons.calendar_today,
              title: 'Work Manager',
              description: 'Plan and schedule using a calendar.',
            ),
            _getRow(
              icon: Icons.people,
              title: 'Employee Management',
              description: 'Manage employee details and tasks.',
            ),
            const SizedBox(height: 3*Constants.padding16),
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
                child: const Text(
                  "Open website",
                  style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFontFamily.suse,
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
    final Uri url = Uri.parse("https://business-manager-website.vercel.app/");
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
                      fontFamily: AppFontFamily.orbitron),
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
