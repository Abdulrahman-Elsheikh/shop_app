// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, invalid_required_positional_param, prefer_is_empty

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Settings Screen',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)));
  }
}
