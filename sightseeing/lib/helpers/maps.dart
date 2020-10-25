import 'dart:convert';

import 'package:http/http.dart' as http;

const GMAP_API_KEY = 'AIzaSyDowYa2_b81dHpLVMWtjsAYtZAIGvGDMkY';

class GMapsHelper {
  static String getMapImageUrl({double latitude, double longtitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longtitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longtitude&key=$GMAP_API_KEY';
  }

  static Future<String> getAddress({
    double latitude,
    double longtitude,
  }) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longtitude&key=$GMAP_API_KEY';
    final responseJson = (await http.get(url)).body;
    return json.decode(responseJson)['results'][0]['formatted_address'];
  }
}
