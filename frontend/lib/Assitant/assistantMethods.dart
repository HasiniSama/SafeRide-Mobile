import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_ride_mobile/Assitant/requestAssitant.dart';
import 'package:safe_ride_mobile/const/appKeys.dart';
import 'package:safe_ride_mobile/models/directionDetails.dart';

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
}