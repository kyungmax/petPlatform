import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('다크 모드(모사)'),
            value: theme.brightness == Brightness.dark,
            onChanged: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('프로토타입: 테마 전환 모사')),
              );
            },
          ),
          const AboutListTile(
            applicationName: 'Pet Platform',
            applicationVersion: '0.1.0',
            applicationLegalese: '© 2025',
          ),
        ],
      ),
    );
  }
}