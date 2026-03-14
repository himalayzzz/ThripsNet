import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

/// Utility class for wind spread prediction calculations.
/// Extracted from SpreadPredictionScreen to enable reuse across the app.
class WindSpreadCalculator {
  /// Fetches current wind data from Open-Meteo API for a given location.
  ///
  /// Returns [WindData] containing wind speed (m/s) and direction (degrees).
  /// Throws [Exception] if the API request fails or data is incomplete.
  static Future<WindData> fetchWind(double lat, double lon) async {
    final uri = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=wind_speed_10m,wind_direction_10m&timezone=auto',
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Unable to fetch weather data (${response.statusCode}).');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final current = body['current'] as Map<String, dynamic>?;
    if (current == null) {
      throw Exception('Weather data not available for this location.');
    }

    final speedKmh = (current['wind_speed_10m'] as num?)?.toDouble();
    final directionDeg = (current['wind_direction_10m'] as num?)?.toDouble();
    if (speedKmh == null || directionDeg == null) {
      throw Exception('Incomplete wind information received.');
    }

    return WindData(speed: speedKmh / 3.6, direction: directionDeg);
  }

  /// Predicts 5 wind spread points from an origin location.
  ///
  /// Algorithm: distance = windSpeed (m/s) × 500 meters
  /// Creates points at angular offsets: -20°, -10°, 0°, +10°, +20° from wind direction
  ///
  /// Returns list of 5 predicted spread locations.
  static List<LatLng> predictSpreadPoints({
    required LatLng origin,
    required double windSpeedMps,
    required double windDirectionDeg,
  }) {
    final distanceInMeters = windSpeedMps * 500;
    const offsets = [-20.0, -10.0, 0.0, 10.0, 20.0];

    return offsets
        .map(
          (offset) =>
              offsetPoint(origin, distanceInMeters, windDirectionDeg + offset),
        )
        .toList();
  }

  /// Calculates a destination point from a start point given distance and bearing.
  ///
  /// Uses geodesic calculations (haversine formula) to account for Earth's curvature.
  ///
  /// [start]: Starting latitude/longitude
  /// [distanceMeters]: Distance to travel in meters
  /// [bearingDegrees]: Direction to travel in degrees (0 = North, 90 = East)
  ///
  /// Returns the destination point as [LatLng].
  static LatLng offsetPoint(
    LatLng start,
    double distanceMeters,
    double bearingDegrees,
  ) {
    const earthRadius = 6371000.0;
    final bearing = bearingDegrees * pi / 180;
    final lat1 = start.latitude * pi / 180;
    final lon1 = start.longitude * pi / 180;
    final angularDistance = distanceMeters / earthRadius;

    final lat2 = asin(
      sin(lat1) * cos(angularDistance) +
          cos(lat1) * sin(angularDistance) * cos(bearing),
    );

    final lon2 =
        lon1 +
        atan2(
          sin(bearing) * sin(angularDistance) * cos(lat1),
          cos(angularDistance) - sin(lat1) * sin(lat2),
        );

    return LatLng(lat2 * 180 / pi, lon2 * 180 / pi);
  }
}

/// Wind data containing speed and direction.
class WindData {
  const WindData({required this.speed, required this.direction});

  final double speed; // Wind speed in m/s
  final double direction; // Wind direction in degrees (0-360)
}
