import 'dart:convert';
import'dart:math' as Math;
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> getCoordinates(String address, String apiKey) async {
  final String encodedAddress = Uri.encodeQueryComponent(address);
  final url =
      'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey';

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

  double a = (Math.sin(dLat / 2) * Math.sin(dLat / 2)) +
      (Math.cos(_degreesToRadians(lat1)) *
          Math.cos(_degreesToRadians(lat2)) *
          Math.sin(dLon / 2) *
          Math.sin(dLon / 2));

  double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

  double distance = radius * c;

  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * (Math.pi / 180);
}