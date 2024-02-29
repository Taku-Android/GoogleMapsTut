import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomLiveLocationTracking extends StatefulWidget {
  const CustomLiveLocationTracking({super.key});

  @override
  State<CustomLiveLocationTracking> createState() => _CustomLiveLocationTrackingState();
}

class _CustomLiveLocationTrackingState extends State<CustomLiveLocationTracking> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;
  late Location location ;
  Set<Marker> markers = {};



  @override
  void initState() {
    super.initState();
    initCameraPosition();
    location = Location();
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
        zoom: 13.0,
        target: LatLng(31.2068347767131, 29.921081125421022));
  }

  Future<void> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if(!isServiceEnabled){
      isServiceEnabled = await location.requestService();
      if(!isServiceEnabled){
        // if he denied the service
      }
    }
    checkAndRequestLocationPermission();
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if(permissionStatus == PermissionStatus.deniedForever){
      return false ;
    }
    if(permissionStatus == PermissionStatus.denied){
      permissionStatus = await location.requestPermission();
      if(permissionStatus != PermissionStatus.granted){
        return false ;
      }
    }
    return true ;
  }

  void getLocationData(){
    location.changeSettings(
      distanceFilter: 3
    );
    location.onLocationChanged.listen((locationData) {

      var cameraPosition = CameraPosition(target: LatLng(locationData.latitude! , locationData.longitude!) , zoom: 17);
      var myLocationMarker = Marker(markerId: const MarkerId('myLocationMarkerId') ,
      position: LatLng(locationData.latitude! , locationData.longitude!)
      );
      markers.add(myLocationMarker);
      setState(() {

      });
      googleMapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    });
  }

  void updateLocation()async{
    await checkAndRequestLocationService();
    var hasPermissions = await checkAndRequestLocationPermission();
    if(hasPermissions){
      getLocationData();
    }
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

