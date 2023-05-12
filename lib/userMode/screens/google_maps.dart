import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:musa3dk/userMode/controllers/googleMap_controller.dart';

class GoogleMaps_ extends StatelessWidget {
  GoogleMaps_({Key? key}) : super(key: key);
  var location;
  var latitude;
  var longitude;
  var title = Get.arguments['title'];
  var imageUrl = Get.arguments['imageUrl'];
  GoogleMapsControllerImp controller = Get.put(GoogleMapsControllerImp());
  get loca => controller.getLatAndLong();
  Set<Marker> myMarker = {
    //  Marker(
    //     visible: true, markerId: const MarkerId('1'), infoWindow: const InfoWindow(),position: LatLng(, controller.longitude)),
  };

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GoogleMapsControllerImp());
    return GetBuilder<GoogleMapsControllerImp>(
        builder: (getXcontroller) => Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      controller.latitude, controller.longitude);
                  print(placemarks[0].country);
                  Get.toNamed("/OrderDetails", arguments: {
                    'title': title,
                    'imageUrl': imageUrl,
                    'locationLat': controller.latitude,
                    'locationLong': controller.longitude,
                  });
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.done),
              ),
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black45),
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Text(
                  "10".tr,
                  style: const TextStyle(
                      fontFamily: "Inria_Serif",
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: getXcontroller.latitude == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GoogleMap(
                      zoomGesturesEnabled: true,
                      markers: {
                        Marker(
                            visible: true,
                            markerId: const MarkerId('1'),
                            infoWindow: const InfoWindow(),
                            position: LatLng(
                                controller.latitude, controller.longitude)),
                      },
                      mapType: MapType.hybrid,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(getXcontroller.latitude,
                              getXcontroller.longitude),
                          zoom: 16),
                      onMapCreated: (GoogleMapController controller) =>
                          getXcontroller.controller_.complete(controller),
                      onCameraMove: (position) {},
                      onTap: (argument) {
                        myMarker.remove(const Marker(markerId: MarkerId('1')));
                        myMarker.add(Marker(
                            markerId: const MarkerId('1'), position: argument));
                        getXcontroller.changeMarker(argument);
                      },
                    ),
            ));
  }
}
