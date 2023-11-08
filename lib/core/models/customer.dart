import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class Customer {
  final String name;
  final String phNo;
  final GeoPoint location;
  final String? buyingProduct;

  Customer(
      {required this.name,
      required this.phNo,
      required this.location,
      this.buyingProduct});

  factory Customer.fromJson(Map jsonData) {
    return Customer(
      name: jsonData['name'],
      phNo: jsonData['phNo'],
      location: jsonData['location'],
      buyingProduct: jsonData['buyingProduct'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['phNo'] = phNo;
    map['location'] = location;
    map['buyingProduct'] = buyingProduct;
    return map;
  }

  bool isNear(Position point) {
    // The Haversine formula can be used to calculate distance between two points on Earth
    const double radius = 6371000; // Earth's radius in meters
    double dLat = (point.latitude - location.latitude) * (pi / 180);
    double dLon = (point.longitude - location.longitude) * (pi / 180);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(location.latitude * (pi / 180)) *
            cos(point.latitude * (pi / 180)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = radius * c;

    // Check if the distance is within 10 meters
    return distance <= 30.0;
  }

  Position toPosition() {
    return Position(
        longitude: location.longitude,
        latitude: location.latitude,
        timestamp: DateTime.now(),
        accuracy: 100,
        altitude: 900,
        altitudeAccuracy: 100,
        heading: 100,
        headingAccuracy: 100,
        speed: 100,
        speedAccuracy: 100);
  }
}
