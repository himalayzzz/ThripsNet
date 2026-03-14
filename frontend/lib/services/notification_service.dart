import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

/// Service for managing local notifications related to wind spread predictions.
class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static bool _isInitialized = false;

  /// Initializes the notification service with platform-specific settings.
  ///
  /// Should be called once during app startup (in main.dart).
  static Future<void> initialize() async {
    if (_isInitialized) return;

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create Android notification channel
    const androidChannel = AndroidNotificationChannel(
      'wind_spread_updates',
      'Wind Spread Updates',
      description: 'Periodic notifications showing predicted wind spread zones',
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);

    _isInitialized = true;
  }

  /// Requests notification permissions from the user.
  ///
  /// Returns true if permission is granted, false otherwise.
  static Future<bool> requestPermissions() async {
    // Android 13+ requires runtime notification permission
    if (await Permission.notification.isDenied) {
      final status = await Permission.notification.request();
      return status.isGranted;
    }

    // iOS permission request
    final iosPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (iosPlugin != null) {
      final granted = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    return true;
  }

  /// Displays a wind spread notification with current prediction data.
  ///
  /// [origin]: The starting point (detection location or current location)
  /// [spreadPoints]: List of 5 predicted spread points
  /// [windSpeed]: Wind speed in m/s
  /// [windDirection]: Wind direction in degrees
  static Future<void> showWindSpreadNotification({
    required LatLng origin,
    required List<LatLng> spreadPoints,
    required double windSpeed,
    required double windDirection,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    final windSpeedKmh = (windSpeed * 3.6).toStringAsFixed(1);
    final windDirectionLabel = _getDirectionLabel(windDirection);
    final windDirectionDeg = windDirection.toStringAsFixed(0);

    // Format spread points for payload
    final spreadPointsJson = spreadPoints
        .map((p) => {'lat': p.latitude, 'lng': p.longitude})
        .toList();

    final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    const androidDetails = AndroidNotificationDetails(
      'wind_spread_updates',
      'Wind Spread Updates',
      channelDescription:
          'Periodic notifications showing predicted wind spread zones',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      styleInformation: BigTextStyleInformation(''),
      groupKey: 'wind_spread_group',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final payload = jsonEncode({
      'origin_lat': origin.latitude.toString(),
      'origin_lon': origin.longitude.toString(),
      'spread_points': jsonEncode(spreadPointsJson),
      'wind_speed': windSpeed.toString(),
      'wind_direction': windDirection.toString(),
    });

    await _notifications.show(
      notificationId,
      'Wind Spread Update',
      'Wind: $windDirectionLabel $windSpeedKmh km/h | 5 spread zones tracked',
      notificationDetails,
      payload: payload,
    );
  }

  /// Cancels all active notifications.
  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  /// Handles notification tap events.
  ///
  /// Currently just logs the tap. Can be extended to navigate to SpreadPredictionScreen.
  static void _onNotificationTapped(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null) {
      try {
        final data = jsonDecode(payload) as Map<String, dynamic>;
        // TODO: Navigate to SpreadPredictionScreen with payload data
        // For now, just print for debugging
        print(
          'Notification tapped with data: ${data['wind_speed']} m/s, ${data['wind_direction']} deg',
        );
      } catch (e) {
        print('Error parsing notification payload: $e');
      }
    }
  }

  /// Converts wind direction in degrees to compass label (N, NE, E, etc.).
  static String _getDirectionLabel(double degrees) {
    const labels = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final index = ((degrees % 360) / 45).round() % 8;
    return labels[index];
  }
}
