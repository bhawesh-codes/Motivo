import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// This MUST be a top-level function
@pragma('vm:entry-point')
void notificationHandler(NotificationResponse response) {
  // This runs in background isolate
  debugPrint('Background notification tapped: ${response.payload}');

  // You can add navigation logic here, but be careful
  // as this runs in background
}
