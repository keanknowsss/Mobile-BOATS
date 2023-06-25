import 'package:boats_mobile_app/constants/api_key.dart';

String apiUrl(var latitude, var longitude) {
  return 'https://api.openweathermap.org/data/3.0/onecall?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&exclude=minutely,hourly&lang';
}
