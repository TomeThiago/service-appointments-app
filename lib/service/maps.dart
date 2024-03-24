import 'dart:convert';
import'dart:math' as math;
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> getCoordinates(String address) async {
  final String encodedAddress = Uri.encodeQueryComponent(address);
  final url =
      'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=AIzaSyCv8vnLN-BMM0nVaVYDfWqYEx30W9Fks6k';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['status'] == 'OK') {

      final location = data['results'][0]['geometry']['location'];

      return {
        'latitude': location['lat'],
        'longitude': location['lng'],
      };
    }
  }
  return null;
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const int radius = 6371;

  double dLat = _degreesToRadians(lat2 - lat1);
  double dLon = _degreesToRadians(lon2 - lon1);

  double a = (math.sin(dLat / 2) * math.sin(dLat / 2)) +
      (math.cos(_degreesToRadians(lat1)) *
          math.cos(_degreesToRadians(lat2)) *
          math.sin(dLon / 2) *
          math.sin(dLon / 2));

  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

  double distance = radius * c;

  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * (math.pi / 180);
}