import 'dart:convert';

class Place {
  final String id;
  final String name;
  final String lat;
  final String lon;

  Place({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: utf8.decode(json['name'].codeUnits),
      lat: json['lat'],
      lon: json['lon'],
    );
  }

  @override
  String toString() {
    return 'Place(id: $id, name: $name, lat: $lat, lon: $lon)';
  }
}
