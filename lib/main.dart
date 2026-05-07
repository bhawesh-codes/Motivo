import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:motivo/screens/splash_screen.dart';
import 'package:motivo/services/notification_services.dart';
import 'package:motivo/theme/app_theme.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  // Don't use async here - show splash screen immediately
  WidgetsFlutterBinding.ensureInitialized();

  debugPrint('🚀 Starting app...');

  // Run initialization in background
  _initializeServices();

  // Show app immediately with splash screen
  runApp(const MyApp());
}

void _initializeServices() async {
  // // Initialize AdMob
  // try {
  //   await MobileAds.instance.initialize();
  //   debugPrint('✅ AdMob initialized');
  // } catch (e) {
  //   debugPrint('❌ AdMob error: $e');
  // }

  // Request permissions
  try {
    await _requestAllPermissions();
    debugPrint('✅ Permissions requested');
  } catch (e) {
    debugPrint('❌ Permission error: $e');
  }

  // Initialize notifications
  try {
    await NotificationServices().init();
    debugPrint('✅ Notifications initialized');

    // Schedule test notification after a delay
    Future.delayed(const Duration(seconds: 3), () {
      NotificationServices().showInstantNotification(
        id: 99,
        title: 'Welcome back to Motivo 🚀',
        body: "Your mindset matters. Let's strengthen it today.",
      );

      NotificationServices().scheduleDailyReminder(
        id: 999,
        title: 'Take a moment for yourself ❤️',
        body: "Read today's quote and reset your mindset.", hour: 7, minute: 0 , 
      );

      NotificationServices().checkPendingNotifications();
    });
  } catch (e) {
    debugPrint('❌ Notification error: $e');
  }
}

Future<void> _requestAllPermissions() async {
  await [
    Permission.notification,
    
    Permission.ignoreBatteryOptimizations,
  ].request();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motivo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
