import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initialCameraPosition;
  late CameraTargetBounds cameraTargetBounds;

  @override
  void initState() {
    super.initState();
    initCameraPosition();
    initCameraBounds();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        cameraTargetBounds: cameraTargetBounds,
        initialCameraPosition: initialCameraPosition);
  }


  initCameraPosition() {
    initialCameraPosition = const CameraPosition(
      // world view 0 -> 3
      // country view 4 -> 6
      // city view 10 -> 13
      // street view 14 -> 17  --- recommended
      // building view 18 -> 20
        zoom: 10.0,
        target: LatLng(31.2068347767131, 29.921081125421022));
  }

  initCameraBounds() {
    cameraTargetBounds = CameraTargetBounds(
        LatLngBounds(
          southwest: const LatLng(30.831856335980262, 29.288566119991444),
          northeast: const LatLng(31.33062249129825, 30.10630654553649),
        ));
  }
}
