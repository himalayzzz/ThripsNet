import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../common/wind_spread_calculator.dart';
import 'notification_service.dart';

/// Manages periodic wind spread notifications that run every 10 seconds.
///
/// This service coordinates GPS location tracking, wind data fetching,
/// spread prediction calculation, and notification display.
class WindSpreadNotificationManager {
  static Timer? _timer;
  static bool _isRunning = false;

  /// Starts the periodic notification loop (every 10 seconds).
  ///
  /// Requests notification permissions before starting.
  /// Throws [Exception] if permissions are denied.
  static Future<void> start() async {
    if (_isRunning) {
      print('Wind spread notifications already running');
      return;
    }

    // Request notification permissions
    final hasPermission = await NotificationService.requestPermissions();
    if (!hasPermission) {
      throw Exception(
        'Notification permission denied. Please enable notifications in settings.',
      );
    }

    _isRunning = true;
    print('Starting wind spread notifications (every 10 seconds)');

    // Run first notification immediately
    await _fetchAndNotify();

    // Then schedule periodic notifications every 10 seconds
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      await _fetchAndNotify();
    });
  }

  /// Stops the periodic notification loop.
  ///
  /// Cancels the timer and clears all active notifications.
  static Future<void> stop() async {
    if (!_isRunning) {
      print('Wind spread notifications not running');
      return;
    }

    _timer?.cancel();
    _timer = null;
    _isRunning = false;

    // Clear all notifications when stopping
    await NotificationService.cancelAll();
    print('Stopped wind spread notifications');
  }

  /// Returns whether notifications are currently running.
  static bool get isRunning => _isRunning;

  /// Fetches current location, wind data, calculates spread, and shows notification.
  ///
  /// Handles errors gracefully to ensure the timer continues running even if one cycle fails.
  static Future<void> _fetchAndNotify() async {
    try {
      // 1. Get current GPS location
      final position = await _getCurrentLocation();
      final origin = LatLng(position.latitude, position.longitude);

      // 2. Fetch wind data from Open-Meteo API
      final wind = await WindSpreadCalculator.fetchWind(
        position.latitude,
        position.longitude,
      );

      // 3. Calculate 5 spread points
      final spreadPoints = WindSpreadCalculator.predictSpreadPoints(
        origin: origin,
        windSpeedMps: wind.speed,
        windDirectionDeg: wind.direction,
      );

      // 4. Show notification
      await NotificationService.showWindSpreadNotification(
        origin: origin,
        spreadPoints: spreadPoints,
        windSpeed: wind.speed,
        windDirection: wind.direction,
      );

      print(
        'Wind spread notification sent: ${wind.speed} m/s at ${wind.direction}°',
      );
    } catch (e) {
      print('Error in wind spread notification cycle: $e');
      // Continue running even if one cycle fails
      // Could show an error notification here if desired
    }
  }

  /// Gets the user's current GPS location.
  ///
  /// Checks and requests location permissions if needed.
  /// Throws [Exception] if location services are disabled or permission is denied.
  static Future<Position> _getCurrentLocation() async {
    // Check if location services are enabled
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      throw Exception('Location services are disabled. Please enable GPS.');
    }

    // Check and request location permission
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception(
        'Location permission denied. Please allow location access.',
      );
    }

    // Get current position with high accuracy
    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      ),
    );
  }
}
