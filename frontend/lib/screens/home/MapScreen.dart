import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe_ride_mobile/providers/location_provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<LocationProvider>(context, listen: false).getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      body: locationProvider.currentPosition != null
          ? GoogleMap(
        onMapCreated: (GoogleMapController controller) {},
        initialCameraPosition: CameraPosition(
          target: LatLng(
            locationProvider.currentPosition!.latitude,
            locationProvider.currentPosition!.longitude,
          ),
          zoom: 15.0,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('redDot'),
            position: LatLng(
              locationProvider.currentPosition!.latitude,
              locationProvider.currentPosition!.longitude,
            ),
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
