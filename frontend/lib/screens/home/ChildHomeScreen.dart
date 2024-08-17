import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe_ride_mobile/const/appColors.dart';
import 'package:safe_ride_mobile/widgets/IconSquare.dart';
import 'package:safe_ride_mobile/widgets/NavBar.dart';
import 'package:safe_ride_mobile/widgets/profile.dart';

import '../../models/child.dart';
import '../../providers/selected.child.dart';
import '../../widgets/PopUp.dart';

class ChildHomeScreen extends StatefulWidget {
  const ChildHomeScreen({
    super.key,
  });

  @override
  State<ChildHomeScreen> createState() => _ChildHomeScreenState();
}

class _ChildHomeScreenState extends State<ChildHomeScreen> {

  String? busId;
  Child? selectedChild;
  GoogleMapController? _mapController;
  Set<Polyline> _polylines = {};
  Marker? _driverMarker;
  Marker? _startLocationMarker;
  Marker? _schoolMarker;
  Marker? _homeMarker;
  LatLng? _updateDriverPosition;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      selectedChild = ModalRoute.of(context)!.settings.arguments as Child?;
      if (selectedChild != null) {
        Provider.of<SelectedChildProvider>(context, listen: false).selectChild(selectedChild!); // Assuming you still need to set the selected child ID
      }
      busId = selectedChild?.selectedBusId;
      if (busId != null) {
        _listenToBusUpdates(busId!);
      }

      setState(() {
        _startLocationMarker = Marker(
          markerId: const MarkerId('startLocationMarker'),
          position: const LatLng(6.7312446, 80.2781262),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // Start location marker in red
        );
        _schoolMarker = Marker(
          markerId: const MarkerId('schoolMarker'),
          position: const LatLng(6.6825, 80.3988),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // School marker in blue
        );
        _homeMarker = Marker(
          markerId: const MarkerId('homeMarker'),
          position: const LatLng(6.7256, 80.3327),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen), // Home marker in green
        );
      });
    });
  }

  void _listenToBusUpdates(String busId) {
    // Setup listeners for the bus data
    DatabaseReference driverPositionRef = FirebaseDatabase.instance.ref().child('busses').child(busId).child('driverPosition');
    driverPositionRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        final driverPosition = (data as Map<dynamic, dynamic>);
        final lat = driverPosition['latitude'] as double;
        final lng = driverPosition['longitude'] as double;
        final newPosition = LatLng(lat, lng);

        setState(() {
          _updateDriverPosition = newPosition;
          _driverMarker = Marker(
            markerId: const MarkerId('driver'),
            position: newPosition,
            infoWindow: const InfoWindow(title: 'Driver'),
          );
        });
        _mapController?.animateCamera(CameraUpdate.newLatLng(newPosition));
      }
    });

    DatabaseReference polylineRef = FirebaseDatabase.instance.ref().child('busses').child(busId).child('polyline');
    polylineRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        List<LatLng> polylinePoints = (data as List<dynamic>).map((point) {
          return LatLng(point['latitude'], point['longitude']);
        }).toList();

        setState(() {
          _polylines = {
            Polyline(
              polylineId: PolylineId('path_$busId'),
              points: polylinePoints,
              color: Colors.pink,
              width: 5,
              jointType: JointType.round,
              geodesic: true,
            ),
          };
        });
      }
    });

    // Listen for status updates
    DatabaseReference statusRef = FirebaseDatabase.instance.ref().child('busses').child(busId).child('status');
    statusRef.onValue.listen((event) {
      final status = event.snapshot.value as String?;
      if (status != null && status == 'Started') {
        // Send a push notification
        _sendPushNotification();
      }
    });
  }

  Future<void> _sendPushNotification() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const BottomPopupBar(
          imageUrl: 'assets/correct.png',
          title: 'Trip Started!',
          buttonText: 'Ok'
        );
      },
    );
  }

  Set<Marker> _createMarkers() {
    return {
      if (_startLocationMarker != null) _startLocationMarker!,
      if (_schoolMarker != null) _schoolMarker!,
      if (_driverMarker != null) _driverMarker!,
      if (_homeMarker != null) _homeMarker!, // Added _homeMarker to the set
    };
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
              child: ProfileCard(
                name: selectedChild?.name ?? ' ',
                email: selectedChild?.schoolName ?? ' ',
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 10.0),
                child: const Divider(
                  height: 2.0,
                  color: appColors.kBlue2,
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: const Row(
                children: <Widget>[
                  IconSquare(
                    navigator: '/bus_list',
                    icon: Icon(
                      Icons.search,
                    ),
                    name: 'Find Busses',
                  ),
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.calendar_today_outlined,
                    ),
                    name: 'Bus Details',
                  ),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 10.0),
                child: const Divider(
                  height: 2.0,
                  color: appColors.kBlue2,
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: const Row(
                children: <Widget>[
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.compare_arrows,
                    ),
                    name: 'Edit Profile',
                  ),
                  IconSquare(
                    navigator: '',
                    icon: Icon(
                      Icons.account_balance,
                    ),
                    name: 'Calender',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 300.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/home'),
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
                        size: 35, // Icon color
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Back', // Your text label
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
      body: GoogleMap(
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
    );
  }
}
