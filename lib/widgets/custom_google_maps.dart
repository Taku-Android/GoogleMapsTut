import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_tut/model/place_model.dart';
import 'package:google_maps_tut/widgets/custom_drawer.dart';
import 'dart:ui' as ui;

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initialCameraPosition;
  late CameraTargetBounds cameraTargetBounds;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};
  Set<Polygon> polygons = {};
  Set<Circle> circles = {};

  @override
  void initState() {
    super.initState();
    initCameraPosition();
    initCameraBounds();
    initMarker();
    initPolyLines();
    initPolygons();
    initCircle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: CustomDrawer(
        onNormalTap: () {
          changeMapStyle(style: 'assets/map_styles/normal.json');
        },
        onRetroTap: () {
          changeMapStyle(style: 'assets/map_styles/retro_style.json');
        },
        onNightTap: () {
          changeMapStyle(style: 'assets/map_styles/night_style.json');
        },
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(children: [
        GoogleMap(
          circles: circles,
          polygons: polygons ,
            polylines: polyLines,
            zoomControlsEnabled: false,
            markers: markers,
            onMapCreated: (controller) {
              googleMapController = controller;
            },
            cameraTargetBounds: cameraTargetBounds,
            initialCameraPosition: initialCameraPosition),
        Positioned(
          bottom: 16,
          right: 16,
          left: 16,
          child: FloatingActionButton(
              child: const Text('Change Location'),
              onPressed: () {
                onCameraBtnChangePress();
              }),
        )
      ]),
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

  initCameraBounds() {
    cameraTargetBounds = CameraTargetBounds(LatLngBounds(
      southwest: const LatLng(30.831856335980262, 29.288566119991444),
      northeast: const LatLng(31.33062249129825, 30.10630654553649),
    ));
  }

  onCameraBtnChangePress() {
    googleMapController.animateCamera(CameraUpdate.newLatLng(
        const LatLng(30.809448713427088, 29.118278000285414)));
    setState(() {});
  }

  changeMapStyle({required String style}) async {
    var retroStyle = await DefaultAssetBundle.of(context).loadString(style);
    googleMapController.setMapStyle(retroStyle);
  }

  Future<Uint8List> getImageFromRawData(String image, int width) async {
    ByteData imageData = await rootBundle.load(image);
    ui.Codec imageCodec = await ui.instantiateImageCodec(
        imageData.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo imageFrame = await imageCodec.getNextFrame();

    ByteData? imageByteData =
        await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);

    return imageByteData!.buffer.asUint8List();
  }

  void initMarker() async {
    // var myCustomMarkerIcon = await BitmapDescriptor.fromAssetImage(
    //     const ImageConfiguration(size: Size(5, 5)),
    //     'assets/images/location.png');
    var myCustomMarkerIcon = BitmapDescriptor.fromBytes( await getImageFromRawData('assets/images/location.png', 100));
    var myMarkers = places
        .map(
          (placeModel) => Marker(
            icon: myCustomMarkerIcon,
            infoWindow: InfoWindow(title: placeModel.name),
            position: placeModel.latLng,
            markerId: MarkerId(
              placeModel.id.toString(),
            ),
          ),
        )
        .toSet();
    markers.addAll(myMarkers);

    setState(() {});
  }

  void initPolyLines() {
    Polyline polyline = const Polyline(polylineId: PolylineId('1') ,
      color: Colors.green,
      width: 5,
      startCap: Cap.roundCap,
      patterns: [PatternItem.dot],
      points: [
        LatLng(31.232110612952468, 29.946100789340026) ,
        LatLng(31.220000217871803, 29.941729018669385) ,
        LatLng(31.246114612685993, 29.966297139036257) ,
        LatLng(31.25611619866536, 29.990003220491054) ,
      ],
    );

    polyLines.add(polyline);

  }

  void initPolygons() {
    Polygon polygon =  Polygon(polygonId: const PolygonId('1') ,
      fillColor: Colors.black.withOpacity(0.2),
      strokeWidth: 5,
      points: const [
        LatLng(31.220000217871803, 29.941729018669385) ,
        LatLng(31.25611619866536, 29.990003220491054) ,
        LatLng(31.21255089602546, 29.992310097388717)
      ],
    );

    polygons.add(polygon);

  }

  void initCircle() {
    Circle carrefourCityLight = const Circle(circleId: CircleId('1') ,
    center: LatLng(31.248422915080603, 29.99422963183022),
      radius: 2000 ,
      strokeWidth: 3
    );

    circles.add(carrefourCityLight);
  }
}