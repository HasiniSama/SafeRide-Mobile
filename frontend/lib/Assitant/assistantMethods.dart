import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_ride_mobile/Assitant/requestAssitant.dart';
import 'package:safe_ride_mobile/const/appKeys.dart';
import 'package:safe_ride_mobile/models/directionDetails.dart';
import 'package:http/http.dart' as http;

class AssistantMethods
{
  static Future<String> searchCordinateAddress(Position position) async
  {
    String placeAddress = "";
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${AppKeys.googleMapApiKey}";

    var response = await RequestAssitant.getRequest(url);

    if(response != "failed")
    {
      placeAddress = response["results"][0]["formatted_address"];
    }

    return placeAddress;
  }

  static Future<DirectionDetails?> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition)
  async {
    String directionUrl = "https://maps.googleapis.com/maps/api/directions/json?destination=${finalPosition.latitude},${finalPosition.longitude}&origin=${initialPosition.latitude},${initialPosition.longitude}&key=${AppKeys.googleMapApiKey}";

    var res = await RequestAssitant.getRequest(directionUrl);

    if(res == "failed")
    {
      return null;
    }
    DirectionDetails directionDetails = DirectionDetails();
    directionDetails.encodedPoints = res["routes"][0]["overview_polyline"]["points"];
    directionDetails.distanceText = res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue = res["routes"][0]["legs"][0]["distance"]["value"];
    directionDetails.durationText = res["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue = res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;
  }

  static Future<List<String>> getSuggestions(String query) async {
    final Uri uri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/autocomplete/json',
      {
        'input': query,
        'key': AppKeys.googleMapApiKey,
        'components': 'country:lk', // Restrict results to Sri Lanka
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return (data['predictions'] as List)
            .map((e) => e['description'] as String)
            .toList();
      }
    }

    return [];
  }

  static Future<Map<String, dynamic>> getPlaceDetails(String placeDescription) async {
    final Uri uri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/findplacefromtext/json',
      {
        'input': placeDescription,
        'inputtype': 'textquery',
        'fields': 'geometry,name',
        'key': AppKeys.googleMapApiKey,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final location = data['candidates'][0]['geometry']['location'];
        final locationName = data['candidates'][0]['name'];
        return {
          'lat': location['lat'],
          'lng': location['lng'],
          'locationName': locationName
        };
      }
    }

    return {};
  }

  static double calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
  }

  static Future<List<Map<String, dynamic>>> findSuitableDrivers(String district, String school) async {
    await Geolocator.requestPermission();

    // Reference to the 'busses' node in Firebase
    DatabaseReference driversRef = FirebaseDatabase.instance.reference().child('busses');

    // Query to find busses by district
    DatabaseEvent event = await driversRef.orderByChild('district').equalTo(district).once();
    DataSnapshot snapshot = event.snapshot;

    List<Map<String, dynamic>> suitableDrivers = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> drivers = snapshot.value as Map<dynamic, dynamic>;

      drivers.forEach((key, value) {
        Map<String, dynamic> driverData = Map<String, dynamic>.from(value);
        driverData['busId'] = key;

        List<dynamic> schools = driverData['schools'] ?? [];
        if (!schools.contains(school)) return;

        suitableDrivers.add(driverData);

        // TODO get pro (LatLng childStartingLocation)
        // double distanceToStartingPoint = calculateDistance(
        //   childStartingLocation.latitude, childStartingLocation.longitude,
        //   driverData['startingPoint']['latitude'], driverData['startingPoint']['longitude'],
        // );
        //
        // double distanceToEndingPoint = calculateDistance(
        //   childStartingLocation.latitude, childStartingLocation.longitude,
        //   driverData['endingPoint']['latitude'], driverData['endingPoint']['longitude'],
        // );
        //
        // if (distanceToStartingPoint < 10000 || distanceToEndingPoint < 10000) {
        //   suitableDrivers.add(driverData);
        // }
      });
    }
    return suitableDrivers;
  }

}