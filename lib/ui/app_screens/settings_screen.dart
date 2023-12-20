import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flavor_ai_testing/constants/colors.dart';
import 'package:flavor_ai_testing/logic/models/recipe.dart';
import 'package:flutter/material.dart';

import '../../logic/services/recipes_service.dart';
import '../components/general_components.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.onGoBack,
  });

  final Function() onGoBack;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    widget.onGoBack.call();
    return true;
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          const BasicTitle(text: "Settings", withGoBack: false),
          const Subtitle(text: "Profile"),
          _buildSetting("Profile settings"),
          const Subtitle(text: "Permissions"),
          _buildSetting("Manage Permissions"),
          const Subtitle(text: "Payment account"),
          _buildSetting("Manage payment account"),
          const Subtitle(text: "Contact"),
          _buildSetting("Contact us"),
          _buildSetting("FAQ"),
          _buildSetting("Help"),
          const Subtitle(text: "Support"),
          _buildSetting("Rate our app"),
          _buildSetting("Feedback"),
          const Subtitle(text: "About"),
          _buildSetting("About us"),
          _buildSetting("Privacy policy"),
          _buildSetting("Terms & Conditions"),
          ]
      ),
    );
  }

  Widget _buildSetting(String setting) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: secondaryBackgroundColor.withOpacity(0.5),
            spreadRadius: 0.25,
            blurRadius: 2,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            setting,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: primaryTextColor,
            size: 18,
          )
        ],
      ),
    );
  }
}
