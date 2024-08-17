import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/widgets/IconSquare.dart';
import 'package:safe_ride_mobile/widgets/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/appKeys.dart';
import '../../widgets/NavBar.dart';
import '../../widgets/PopUp.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  GoogleMapController? _mapController;
  String? firstName;
  String? lastName;
  String? email;
  String? busId;
  String? driverID;
  late List<LatLng> _locations = [];
  Set<Polyline> _polylines = {};
  Marker? _driverMarker;
  LatLng _currentDriverPosition = const LatLng(6.7312446, 80.2781262);

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _getCurrentLocation();
    _driverMarker = Marker(
      markerId: const MarkerId('driver'),
      position: _currentDriverPosition,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName');
      lastName = prefs.getString('lastName');
      email = prefs.getString('email');
      driverID = prefs.getString('uid');
    });
  }

  Future<void> _showPathMap() async {
    _locations = [];
    DatabaseReference busRef = FirebaseDatabase.instance.ref().child('busses');
    Query query = busRef.orderByChild('driverId').equalTo(driverID);

    DataSnapshot snapshot = await query.once().then((DatabaseEvent event) => event.snapshot);

    if (snapshot.value != null) {
      Map<dynamic, dynamic> buses = snapshot.value as Map<dynamic, dynamic>;
      buses.forEach((key, busData) {
        busId = key;

        _locations.add(_currentDriverPosition);
        if (busData['children'] != null) {
          Map<dynamic, dynamic> children = busData['children'];
          children.forEach((childKey, childData) {
            if (childData['startingLocation'] != null) {
              _locations.add(LatLng(
                double.parse(childData['startingLocation']['lat']),
                double.parse(childData['startingLocation']['lng']),
              ));
            }
          });
        }

        if (busData['schools'] != null) {
          List<dynamic> schools = busData['schools'];
          for (var school in schools) {
            _locations.add(LatLng(
              school['lat'],
              school['lng'],
            ));
          }
        }
      });

      if (_locations.length > 1) {
        await _getRoute();
      }

      setState(() {});
    }
  }

  Future<void> _showPathMapEvening() async {
    _locations = [];
    DatabaseReference busRef = FirebaseDatabase.instance.ref().child('busses');
    Query query = busRef.orderByChild('driverId').equalTo(driverID);

    DataSnapshot snapshot = await query.once().then((DatabaseEvent event) => event.snapshot);

    if (snapshot.value != null) {
      Map<dynamic, dynamic> buses = snapshot.value as Map<dynamic, dynamic>;
      buses.forEach((key, busData) {
        busId = key;

        _locations.add(_currentDriverPosition);
        if (busData['children'] != null) {
          Map<dynamic, dynamic> children = busData['children'];
          children.forEach((childKey, childData) {
            if (childData['startingLocation'] != null) {
              _locations.add(LatLng(
                double.parse(childData['startingLocation']['lat']),
                double.parse(childData['startingLocation']['lng']),
              ));
            }
          });
        }

        if (busData['schools'] != null) {
          List<dynamic> schools = busData['schools'];
          for (var school in schools) {
            _locations.add(LatLng(
              school['lat'],
              school['lng'],
            ));
          }
        }
      });

      if (_locations.length > 1) {
        await _getRoute();
      }

      setState(() {});
    }
  }

  Future<void> _getRoute() async {
    String url = 'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${_locations.first.latitude},${_locations.first.longitude}&'
        'destination=${_locations.last.latitude},${_locations.last.longitude}&'
        'waypoints=optimize:true|${_locations.sublist(1, _locations.length - 1).map((loc) => '${loc.latitude},${loc.longitude}').join('|')}&'
        'key=${AppKeys.googleMapApiKey}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        var points = data['routes'][0]['overview_polyline']['points'];
        List<LatLng> polylinePoints = _decodePolyline(points);

        // Save the polyline points to Firebase
        DatabaseReference polylineRef = FirebaseDatabase.instance.ref().child('busses')
            .child(busId!).child('polyline');
        polylineRef.set(polylinePoints.map((point) => {
          'latitude': point.latitude,
          'longitude': point.longitude,
        }).toList());

        setState(() {
          _polylines = {
            Polyline(
              polylineId: const PolylineId('path'),
              points: polylinePoints,
              color: Colors.pink,
              width: 5,
              jointType: JointType.round,
              geodesic: true
            ),
          };
        });
      } else {
        throw Exception('Error fetching directions: ${data['status']}');
      }
    } else {
      throw Exception('Failed to load directions');
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polyline;
  }

  void _updateDriverPosition(LatLng newPosition) {

    DatabaseReference driverPositionRef = FirebaseDatabase.instance.ref().child('busses').child(busId!).child('driverPosition');
    driverPositionRef.set({
      'latitude': newPosition.latitude,
      'longitude': newPosition.longitude,
    });
    setState(() {
      _currentDriverPosition = newPosition;
      _driverMarker = Marker(
        markerId: const MarkerId('driver'),
        position: _currentDriverPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
    });
  }

  Future<void> _startDemo() async {
    if (_polylines.isEmpty) return;

    DatabaseReference statusRef = FirebaseDatabase.instance.ref().child('busses')
        .child(busId!).child('status');

    statusRef.set("Started");

    // Get the polyline points from the first polyline (assuming there's only one)
    List<LatLng> routePoints = _polylines.first.points;
    int currentPointIndex = 0;
    statusRef.set("Ongoing");

    DatabaseReference alertRef = FirebaseDatabase.instance.ref().child('busses')
        .child(busId!).child('alert');

    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (currentPointIndex >= routePoints.length) {
        timer.cancel();
        statusRef.set("Completed");
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return BottomPopupBar(
              imageUrl: 'assets/correct.png',
              title: 'Trip Complete!',
              buttonText: 'Ok',
              onPressed: () {
                statusRef.set("Idle");
              },
            );
          },
        );
      } else {
        LatLng newPosition = routePoints[currentPointIndex];
        _updateDriverPosition(newPosition);

        const LatLng fixedLocation = LatLng(6.7256, 80.3327);
        double distance = _calculateDistance(newPosition, fixedLocation);
        // Assuming an average speed of 60 km/h
        double averageSpeed = 60.0; // in km/h
        double timeInHours = distance / averageSpeed;
        double timeInMinutes = timeInHours * 60;

        // Check if the time to reach the fixed location is about 5 minutes
        if (timeInMinutes <= 5) {
          alertRef.set("5");
        } else if (timeInMinutes <= 10) {
          alertRef.set("10");
        }
        // Move the camera to follow the driver's marker
        _mapController?.animateCamera(
          CameraUpdate.newLatLng(newPosition),
        );

        currentPointIndex++;
      }
    });
  }

  // Function to calculate the distance between two LatLng points
  double _calculateDistance(LatLng start, LatLng end) {
    const double earthRadiusKm = 6371;

    double dLat = _degreesToRadians(end.latitude - start.latitude);
    double dLng = _degreesToRadians(end.longitude - start.longitude);

    double a =
        sin(dLat / 2) * sin(dLat / 2) +
            cos(_degreesToRadians(start.latitude)) * cos(_degreesToRadians(end.latitude)) *
                sin(dLng / 2) * sin(dLng / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  Set<Marker> _createMarkers() {
    // Filter out the driver's location from _locations
    Set<Marker> markers = _locations
        .where((location) => location != _currentDriverPosition)
        .map((location) {
      return Marker(
        markerId: MarkerId(location.latitude.toString() + location.longitude.toString()),
        position: location,
      );
    }).toSet();

    // Add the driver's marker if it exists
    if (_driverMarker != null) {
      markers.add(_driverMarker!);
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: firstName != null && lastName != null && email != null
                  ? ProfileCard(
                name: '$firstName $lastName',
                email: email!,
              )
                  : const Center(child: CircularProgressIndicator()),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: const Row(
                children: <Widget>[
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.home,
                    ),
                    name: 'Edit Profile',
                  ),
                  IconSquare(
                    navigator: '/driver_profile',
                    icon: Icon(
                      Icons.add_circle,
                    ),
                    name: 'Bus Details',
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: const Row(
                children: <Widget>[
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.search,
                    ),
                    name: 'Transaction history',
                  ),
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.calendar_today_outlined,
                    ),
                    name: 'Bank Details',
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: const Row(
                children: <Widget>[
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.compare_arrows,
                    ),
                    name: 'Calendar',
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 50.0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        appColors.kBlueGreenGra1,
                        appColors.kBlueGreenGra2
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Icon(
                          Icons.arrow_circle_left,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(6.72661, 80.29267), // Starting location for the map
              zoom: 12.0,
            ),
            markers: _createMarkers(),
            polylines: _polylines,
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                if (kDebugMode) {
                  _showPathMap();
                  _startDemo();
                }
              },
              child: const Icon(Icons.navigation),
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                if (kDebugMode) {
                  // _showPathMapEvening();
                  // _startDemo();
                }
              },
              child: const Icon(Icons.navigation),
            ),
          ),
        ],
      ),
    );
  }

  void _getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, don't continue
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, don't continue
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Update the current driver position
    // setState(() {
    //   _currentDriverPosition =
    //       LatLng(position.latitude, position.longitude);
    //
    //   // Update the marker position
    //   _driverMarker = Marker(
    //     markerId: const MarkerId('driver'),
    //     position: _currentDriverPosition,
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    //   );
    // });
  }

  // Set<Marker> _createMarkers() {
  //   return _locations.map((location) {
  //     return Marker(
  //       markerId: MarkerId(location.latitude.toString() + location.longitude.toString()),
  //       position: location,
  //     );
  //   }).toSet();
  // }
}
