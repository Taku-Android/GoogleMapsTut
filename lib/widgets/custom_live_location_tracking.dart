import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_tut/utils/location_service.dart';
import 'package:location/location.dart';

class CustomLiveLocationTracking extends StatefulWidget {
  const CustomLiveLocationTracking({super.key});

  @override
  State<CustomLiveLocationTracking> createState() =>
      _CustomLiveLocationTrackingState();
}

class _CustomLiveLocationTrackingState
    extends State<CustomLiveLocationTracking> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;
  late LocationService locationService;

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    initCameraPosition();
    locationService = LocationService();
    updateLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          zoomControlsEnabled: false,
          markers: markers,
          onMapCreated: (controller) {
            googleMapController = controller;
          },
          initialCameraPosition: initialCameraPosition),
    );
  }

  initCameraPosition() {
    initialCameraPosition = const CameraPosition(
        // world view 0 -> 3
        // country view 4 -> 6
        // city view 10 -> 13
        // street view 14 -> 17  --- recommended
        // building view 18 -> 20
        zoom: 5.0,
        target: LatLng(31.2068347767131, 29.921081125421022));
  }

  void updateLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermissions =
        await locationService.checkAndRequestLocationPermission();
    if (hasPermissions) {
      locationService.location.changeSettings(distanceFilter: 2);
      locationService.getRealTimeLocationData((locationData) {
        setLocationMarker(locationData);
        setCameraPosition(locationData);
      });
    }
  }

  bool isFirstCall = true ;
  void setCameraPosition(LocationData locationData) {
    if(isFirstCall){
      var cameraPosition = CameraPosition(target: LatLng(locationData.latitude!, locationData.longitude!) , zoom: 15);
      googleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {
        isFirstCall = false ;
      });

    }else{
      googleMapController
          ?.animateCamera(CameraUpdate.newLatLng(LatLng(locationData.latitude!, locationData.longitude!)));

    }
  }

  void setLocationMarker(LocationData locationData) {
    var myLocationMarker = Marker(
        markerId: const MarkerId('myLocationMarkerId'),
        position: LatLng(locationData.latitude!, locationData.longitude!));
    markers.add(myLocationMarker);
    setState(() {});
  }
}

/**
 * 1- check location service is on
 *
 * 2- get permission of location
 *
 * 3- get location
 *
 * 4- display
 *
 */
