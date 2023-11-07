import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flavor_ai_testing/logic/models/recipe.dart';
import 'package:flutter/material.dart';

import '../../logic/services/recipes_service.dart';

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
    return const Center(
      child: Text("Settings"),
    );
  }
}
