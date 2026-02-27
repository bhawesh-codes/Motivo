import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

class NotificationServices {
  static final NotificationServices _instance =
      NotificationServices._internal();

  factory NotificationServices() => _instance;

  NotificationServices._internal();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Channel IDs
  static const String dailyChannelId = 'motivo_daily_channel';
  static const String dailyChannelName = 'Daily Motivation';
  static const String dailyChannelDescription =
      'Daily motivational quote notifications';

  static const String instantChannelId = 'motivo_instant_channel';
  static const String instantChannelName = 'Instant Notifications';
  static const String instantChannelDescription =
      'Instant notification channel';

  Future<void> init() async {
    try {
      // Initialize timezone
      initializeTimeZones();
      try {
        setLocalLocation(getLocation('Asia/Kathmandu'));
      } catch (_) {
        setLocalLocation(getLocation('UTC'));
      }

      // Android initialization
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const InitializationSettings settings =
          InitializationSettings(android: androidSettings);

      await notificationsPlugin.initialize(
        settings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          debugPrint('Notification tapped: ${response.payload}');
        },
      );

      // Request notification permission (Android 13+)
      final androidImplementation =
          notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        await androidImplementation.requestNotificationsPermission();

        // Create daily channel
        const AndroidNotificationChannel dailyChannel =
            AndroidNotificationChannel(
          dailyChannelId,
          dailyChannelName,
          description: dailyChannelDescription,
          importance: Importance.max,
          enableVibration: true,
          playSound: true,
          showBadge: true,
        );

        await androidImplementation.createNotificationChannel(dailyChannel);

        // Create instant channel
        const AndroidNotificationChannel instantChannel =
            AndroidNotificationChannel(
          instantChannelId,
          instantChannelName,
          description: instantChannelDescription,
          importance: Importance.max,
        );

        await androidImplementation.createNotificationChannel(instantChannel);
      }

      debugPrint('Notification service initialized');
    } catch (e) {
      debugPrint('Init error: $e');
    }
  }

  // -----------------------
  // Instant Notification
  // -----------------------

  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      instantChannelId,
      instantChannelName,
      channelDescription: instantChannelDescription,
      importance: Importance.max,
      priority: Priority.high,
      icon: 'ic_notification',
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await notificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }

  // -----------------------
  // Schedule Daily Reminder
  // -----------------------

  Future<void> scheduleDailyReminder({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    String? payload,
  }) async {
    final now = TZDateTime.now(local);

    TZDateTime scheduledDate = TZDateTime(
      local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // If time already passed today → schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      dailyChannelId,
      dailyChannelName,
      channelDescription: dailyChannelDescription,
      importance: Importance.max,
      priority: Priority.high,
      icon: 'ic_notification',
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.inexact,
      matchDateTimeComponents: DateTimeComponents.time, // Repeat daily
      payload: payload,
    );

    debugPrint('Daily reminder scheduled at $hour:$minute');
  }

  // -----------------------
  // Cancel Notification
  // -----------------------

  Future<void> cancelNotification(int id) async {
    await notificationsPlugin.cancel(id);
  }

  Future<void> cancelAll() async {
    await notificationsPlugin.cancelAll();
  }

  // -----------------------
  // Debug Pending
  // -----------------------

  Future<void> checkPendingNotifications() async {
    final pending =
        await notificationsPlugin.pendingNotificationRequests();

    debugPrint('Pending notifications: ${pending.length}');
    for (var n in pending) {
      debugPrint('ID: ${n.id}, Title: ${n.title}');
    }
  }
}