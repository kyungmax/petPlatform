import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'router.dart';

class PetPlatformApp extends StatelessWidget {
  const PetPlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = buildRouter();

    return MaterialApp.router(
      title: 'Pet Platform',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      routerConfig: router,
    );
  }
}