import 'package:flutter/material.dart';
import 'package:minimalchatapp/components/my_drawer.dart';
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
    drawer: MyDrawer(),
    );
  }
}
