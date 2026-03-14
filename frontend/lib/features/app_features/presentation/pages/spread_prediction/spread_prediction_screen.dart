import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../../../../../common/app_theme.dart';
import '../alert_notification/alert_notification_screen.dart';

class SpreadPredictionScreen extends StatefulWidget {
  const SpreadPredictionScreen({super.key});

  @override
  State<SpreadPredictionScreen> createState() => _SpreadPredictionScreenState();
}

class _SpreadPredictionScreenState extends State<SpreadPredictionScreen> {
  bool _isLoading = true;
  String? _error;
  LatLng? _origin;
  List<LatLng> _predictedPoints = const [];
  double _windSpeed = 0;
  double _windDirection = 0;

  @override
  void initState() {
    super.initState();
    _loadPrediction();
  }

  Future<void> _loadPrediction() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final position = await _requestCurrentLocation();
      final wind = await _fetchWind(position.latitude, position.longitude);

      final origin = LatLng(position.latitude, position.longitude);
      final points = _predictSpreadPoints(
        origin: origin,
        windSpeedMps: wind.speed,
        windDirectionDeg: wind.direction,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _origin = origin;
        _predictedPoints = points;
        _windSpeed = wind.speed;
        _windDirection = wind.direction;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<Position> _requestCurrentLocation() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      throw Exception('Location services are disabled. Enable GPS and try again.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied. Please allow location access.');
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  Future<_WindData> _fetchWind(double lat, double lon) async {
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

    return _WindData(speed: speedKmh / 3.6, direction: directionDeg);
  }

  List<LatLng> _predictSpreadPoints({
    required LatLng origin,
    required double windSpeedMps,
    required double windDirectionDeg,
  }) {
    final distanceInMeters = windSpeedMps * 500;
    const offsets = [-20.0, -10.0, 0.0, 10.0, 20.0];

    return offsets
        .map((offset) => _offsetPoint(origin, distanceInMeters, windDirectionDeg + offset))
        .toList();
  }

  LatLng _offsetPoint(LatLng start, double distanceMeters, double bearingDegrees) {
    const earthRadius = 6371000.0;
    final bearing = bearingDegrees * pi / 180;
    final lat1 = start.latitude * pi / 180;
    final lon1 = start.longitude * pi / 180;
    final angularDistance = distanceMeters / earthRadius;

    final lat2 = asin(
      sin(lat1) * cos(angularDistance) +
          cos(lat1) * sin(angularDistance) * cos(bearing),
    );

    final lon2 = lon1 +
        atan2(
          sin(bearing) * sin(angularDistance) * cos(lat1),
          cos(angularDistance) - sin(lat1) * sin(lat2),
        );

    return LatLng(lat2 * 180 / pi, lon2 * 180 / pi);
  }

  String _directionLabel(double degrees) {
    const labels = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final index = ((degrees % 360) / 45).round() % 8;
    return labels[index];
  }

  Widget _legendItem({required Color color, required String text}) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final origin = _origin;
    final mapPoints = <LatLng>[
      ...(origin == null ? const <LatLng>[] : [origin]),
      ..._predictedPoints,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Spread Prediction',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF71CFC0), Color(0xFFA7E3D8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x2271BFB3),
                  blurRadius: 24,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Spread Forecast',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 25),
                ),
                SizedBox(height: 8),
                Text(
                  'Prediction combines detected infection point and wind flow to estimate nearby risk zones.',
                  style: TextStyle(color: Color(0xFFF0FFFB), fontWeight: FontWeight.w600, fontSize: 15.5, height: 1.35),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Card(
            color: AppColors.softBlue,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 280,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : _error != null
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      _error!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                )
                              : FlutterMap(
                                  options: MapOptions(
                                    initialCenter: origin ?? const LatLng(12.9716, 77.5946),
                                    initialZoom: 11.5,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName: 'com.example.frontend',
                                    ),
                                    PolylineLayer(
                                      polylines: [
                                        Polyline(
                                          points: mapPoints,
                                          strokeWidth: 3,
                                          color: AppColors.blue,
                                        ),
                                      ],
                                    ),
                                    MarkerLayer(
                                      markers: [
                                        if (origin != null)
                                          Marker(
                                            point: origin,
                                            width: 38,
                                            height: 38,
                                            child: const Icon(
                                              Icons.place,
                                              color: Color(0xFFD9493F),
                                              size: 34,
                                            ),
                                          ),
                                        ..._predictedPoints.map(
                                          (point) => Marker(
                                            point: point,
                                            width: 30,
                                            height: 30,
                                            child: const Icon(
                                              Icons.location_on,
                                              color: Color(0xFFE6952B),
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _legendItem(color: Color(0xFFD9493F), text: 'Detection location (origin)'),
                  const SizedBox(height: 6),
                  _legendItem(color: Color(0xFFE6952B), text: 'Next 5 likely wind spread spots'),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    FilledButton.tonalIcon(
                      onPressed: _loadPrediction,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Retry Location & Weather'),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Wind Direction', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                        const SizedBox(height: 4),
                        Text(
                          _isLoading ? 'Loading...' : '${_directionLabel(_windDirection)} (${_windDirection.toStringAsFixed(0)} deg)',
                          style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Wind Speed', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                        const SizedBox(height: 4),
                        Text(
                          _isLoading ? 'Loading...' : '${(_windSpeed * 3.6).toStringAsFixed(1)} km/h',
                          style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Text(
                'Location is requested on this page, then the app predicts and plots five likely spread spots from current wind flow.',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AlertNotificationScreen()),
              );
            },
            icon: const Icon(Icons.notification_add_rounded),
            label: const Text(
              'Send Alert',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _WindData {
  const _WindData({required this.speed, required this.direction});

  final double speed;
  final double direction;
}
