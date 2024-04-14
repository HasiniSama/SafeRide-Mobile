import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe_ride_mobile/providers/location_provider.dart';

import '../../AllWidgets/progressDialog.dart';
import '../../Assitant/assistantMethods.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polyLineSet = {};

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  var geoLocator = Geolocator();

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<LocationProvider>(context, listen: false).getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    void locatePosition() async
    {
      LatLng latLngPosition = LatLng(locationProvider.currentPosition!.latitude, locationProvider.currentPosition!.longitude);
      CameraPosition cameraPosition = new CameraPosition(target: latLngPosition, zoom: 14);
      newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }

    return Scaffold(
      body: locationProvider.currentPosition != null
          ? GoogleMap(
        polylines: polyLineSet,
        markers: markersSet,
        circles: circlesSet,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controllerGoogleMap.complete(controller);
          newGoogleMapController = controller;

          locatePosition();
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            locationProvider.currentPosition!.latitude,
            locationProvider.currentPosition!.longitude,
          ),
        ),
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getPlaceDirection();
        },
        child: const Icon(Icons.directions),
      ),
    );
  }
  Future<void> getPlaceDirection() async
  {
    var initialPosition = Provider.of<LocationProvider>(context, listen: false).currentPosition;

    var pickupLatLang = LatLng(initialPosition!.latitude, initialPosition.longitude);
    var dropOffLatLang = const LatLng(6.6927819, 80.385547);

    showDialog(context: context, builder: (BuildContext context) => ProgressDialog(message: "Please wait ..."));

    var details = await AssistantMethods.obtainPlaceDirectionDetails(pickupLatLang, dropOffLatLang);

    Navigator.pop(context);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolylinePointResults = polylinePoints.decodePolyline(details!.encodedPoints!);

    pLineCoordinates.clear();

    if(decodedPolylinePointResults.isNotEmpty)
    {
      for (var pointLatLng in decodedPolylinePointResults) {
        pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      }
    }

    polyLineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
          color: Colors.pink,
          polylineId: const PolylineId('PolylineID'),
          jointType: JointType.round,
          points: pLineCoordinates,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap
      );
      
      polyLineSet.add(polyline);
    });

    LatLngBounds latLngBounds;
    if(pickupLatLang.latitude > dropOffLatLang.latitude && pickupLatLang.longitude > dropOffLatLang.longitude)
    {
      latLngBounds = LatLngBounds(southwest: dropOffLatLang, northeast: pickupLatLang);
    }
    else if(pickupLatLang.longitude > dropOffLatLang.longitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(pickupLatLang.latitude, dropOffLatLang.longitude), northeast: LatLng(dropOffLatLang.latitude, pickupLatLang.longitude));
    }
    else if(pickupLatLang.latitude > dropOffLatLang.latitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(dropOffLatLang.latitude, pickupLatLang.longitude), northeast: LatLng(pickupLatLang.latitude, dropOffLatLang.longitude));
    }
    else
    {
      latLngBounds = LatLngBounds(southwest: pickupLatLang, northeast: dropOffLatLang);
    }

    newGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickupMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: initialPosition.latitude.toString(), snippet: "My Location"),
      position: pickupLatLang,
      markerId: const MarkerId("pickupId")
    );
    Marker dropOffMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: dropOffLatLang.latitude.toString(), snippet: "My DropOff Location"),
        position: dropOffLatLang,
        markerId: const MarkerId("dropOffId")
    );

    setState(() {
      markersSet.add(pickupMarker);
      markersSet.add(dropOffMarker);
    });

    Circle pickupCircle = Circle(
      fillColor: Colors.blueAccent,
      center: pickupLatLang,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: const CircleId("pickupID")
    );
    Circle dropOffCircle = Circle(
        fillColor: Colors.deepPurple,
        center: dropOffLatLang,
        radius: 12,
        strokeWidth: 4,
        strokeColor: Colors.deepPurple,
        circleId: const CircleId("dropOffID")
    );

    setState(() {
      circlesSet.add(pickupCircle);
      circlesSet.add(dropOffCircle);
    });
  }
}
