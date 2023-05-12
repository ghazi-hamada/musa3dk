import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../controller/localization/mylocacionService.dart';

abstract class GoogleMapsController extends GetxController {
  getMyLocation();
  getLatAndLong();
  animateCamera(LatLng location);
  changeMarker(LatLng argument);
}

class GoogleMapsControllerImp extends GoogleMapsController {
  Position? location;
  var latitude;
  var longitude;
  LatLng? newLocation;

  TextEditingController searchController = TextEditingController();
  final Completer<GoogleMapController> controller_ =
      Completer<GoogleMapController>();
  @override
  Future<void> getMyLocation() async {
    LocationData myLocation = await myLocationService().getLocation();
    animateCamera(LatLng(myLocation.latitude!, myLocation.longitude!));
  }

  @override
  Future<void> animateCamera(LatLng location) async {
    final GoogleMapController controller = await controller_.future;
    CameraPosition cameraPosition = CameraPosition(
      target: location,
      zoom: 13.00,
    );
    print(
        "animating camera to (lat: ${location.latitude}, long: ${location.longitude}");
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Future<Position?> getLatAndLong() async {
    location = await Geolocator.getCurrentPosition().then((value) => value);
    latitude = location!.latitude;
    longitude = location!.longitude;
    update();
    return location;
  }

  @override
  void onInit() {
    //getpostion();
    getLatAndLong();
    searchController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future getpostion() async {
    bool services;
    LocationPermission permission;
    services = await Geolocator.isLocationServiceEnabled();

    if (services == false) {
      Get.defaultDialog(
        title: "services",
        middleText: "Services Not Enabled!",
        // backgroundColor: Colors.green,
        // titleStyle: const TextStyle(color: Colors.white),
        // middleTextStyle: const TextStyle(color: Colors.white),
      );
    }
    permission = await Geolocator.checkPermission();
    print("****************** $permission");
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.always) {}
  }

  @override
  changeMarker(LatLng argument) {
    newLocation = argument;
    update();
  }
}
