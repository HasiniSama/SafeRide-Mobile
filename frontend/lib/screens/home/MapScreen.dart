import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle denied permission
      print('Location permission denied');
    } else if (permission == LocationPermission.deniedForever) {
      // Handle permanently denied permission
      print('Location permission denied permanently');
    } else {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition != null
          ? GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude),
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('redDot'),
                  position: LatLng(
                      _currentPosition!.latitude, _currentPosition!.longitude),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
                ),
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
