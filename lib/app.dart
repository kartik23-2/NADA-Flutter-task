import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/profiles/presentation/screens/profile_list_screen.dart';

/// Root Application Widget configuring theme and entrypoint
class NadaApp extends StatelessWidget {
  const NadaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nada Profiles',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ProfileListScreen(),
    );
  }
}
