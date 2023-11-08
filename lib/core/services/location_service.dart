import 'dart:math';

import 'package:cholay_ice_sale/core/models/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static Future<Position?> getCurrentLocation() async {
    var status = await Permission.location.request();
    Position? currentPosition;

    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
      currentPosition = position;
    } else {
      currentPosition = null;
    }
    return currentPosition;
  }

  static Position? findNearestLocation(
      Position target, List<Position> availableLocations) {
    if (availableLocations.isEmpty) {
      return null;
    }

    Position nearestLocation = availableLocations[0];
    double shortestDistance = _calculateDistance(target, nearestLocation);

    for (var location in availableLocations) {
      double distance = _calculateDistance(target, location);
      if (distance < shortestDistance) {
        nearestLocation = location;
        shortestDistance = distance;
      }
    }

    return nearestLocation;
  }

  static Customer findNearestCustomer(
      Position target, List<Customer> availableCustomers) {
    Customer returnCus = availableCustomers[0];
    Position nearestLocation = availableCustomers[0].toPosition();
    double shortestDistance = _calculateDistance(target, nearestLocation);

    for (var customer in availableCustomers) {
      double distance = _calculateDistance(target, customer.toPosition());
      if (distance < shortestDistance) {
        nearestLocation = customer.toPosition();
        shortestDistance = distance;
        returnCus = customer;
      }
    }

    return returnCus;
  }

  static double _calculateDistance(Position location1, Position location2) {
    const double earthRadius = 6371000; // Radius of the Earth in meters
    double lat1 = location1.latitude * (pi / 180);
    double lon1 = location1.longitude * (pi / 180);
    double lat2 = location2.latitude * (pi / 180);
    double lon2 = location2.longitude * (pi / 180);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }
}
