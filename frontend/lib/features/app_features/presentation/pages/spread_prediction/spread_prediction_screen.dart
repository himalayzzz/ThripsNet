import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../../../../../common/app_theme.dart';
import '../../../../../common/wind_spread_calculator.dart';
import '../../../../../services/wind_spread_notification_manager.dart';
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
  bool _notificationsActive = false;

  @override
  void initState() {
    super.initState();
    _loadPrediction();
    _updateNotificationStatus();
  }

  @override
  void dispose() {
    // Note: We don't stop notifications on dispose - let user control that
    super.dispose();
  }

  void _updateNotificationStatus() {
    setState(() {
      _notificationsActive = WindSpreadNotificationManager.isRunning;
    });
  }

  Future<void> _loadPrediction() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final position = await _requestCurrentLocation();
      final wind = await WindSpreadCalculator.fetchWind(
        position.latitude,
        position.longitude,
      );

      final origin = LatLng(position.latitude, position.longitude);
      final points = WindSpreadCalculator.predictSpreadPoints(
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
      throw Exception(
        'Location services are disabled. Enable GPS and try again.',
      );
    }

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

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  Future<void> _toggleNotifications() async {
    try {
      if (_notificationsActive) {
        await WindSpreadNotificationManager.stop();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wind spread notifications stopped'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        await WindSpreadNotificationManager.start();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Wind spread notifications started (every 10 seconds)',
              ),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
      _updateNotificationStatus();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
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
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
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
        actions: [
          // Notification status indicator
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _notificationsActive
                    ? Colors.green.shade100
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _notificationsActive
                        ? Icons.notifications_active
                        : Icons.notifications_off,
                    size: 16,
                    color: _notificationsActive
                        ? Colors.green.shade700
                        : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _notificationsActive ? 'Active' : 'Paused',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _notificationsActive
                          ? Colors.green.shade700
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleNotifications,
        backgroundColor: _notificationsActive ? Colors.orange : AppColors.blue,
        child: Icon(
          _notificationsActive ? Icons.notifications_off : Icons.notifications_active,
          color: Colors.white,
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
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Prediction combines detected infection point and wind flow to estimate nearby risk zones.',
                  style: TextStyle(
                    color: Color(0xFFF0FFFB),
                    fontWeight: FontWeight.w600,
                    fontSize: 15.5,
                    height: 1.35,
                  ),
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
                                initialCenter:
                                    origin ?? const LatLng(12.9716, 77.5946),
                                initialZoom: 11.5,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                  _legendItem(
                    color: Color(0xFFD9493F),
                    text: 'Detection location (origin)',
                  ),
                  const SizedBox(height: 6),
                  _legendItem(
                    color: Color(0xFFE6952B),
                    text: 'Next 5 likely wind spread spots',
                  ),
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
                        const Text(
                          'Wind Direction',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _isLoading
                              ? 'Loading...'
                              : '${_directionLabel(_windDirection)} (${_windDirection.toStringAsFixed(0)} deg)',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            fontSize: 17,
                          ),
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
                        const Text(
                          'Wind Speed',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _isLoading
                              ? 'Loading...'
                              : '${(_windSpeed * 3.6).toStringAsFixed(1)} km/h',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            fontSize: 17,
                          ),
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
                MaterialPageRoute(
                  builder: (_) => const AlertNotificationScreen(),
                ),
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
