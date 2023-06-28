import 'package:boats_mobile_app/constants/api_key.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String weatherApiUrl(var latitude, var longitude) {
  return 'https://api.openweathermap.org/data/3.0/onecall?lat=$latitude&lon=$longitude&appid=$weatherApiKey&units=metric&exclude=minutely,hourly&lang';
}

String getDirectionUrl(String origin, String destination) {
  return 'https://maps.googleapis.com/maps/api/directions/json?destination=$destination&origin=$origin&key=$googleApiKey';
}

String getDistanceUrl(LatLng origin, LatLng destination) {
  return 'https://maps.googleapis.com/maps/api/directions/json?'
      'origin=${origin.latitude},${origin.longitude}'
      '&destination=${destination.latitude},${destination.longitude}'
      '&key=$googleApiKey';
}
