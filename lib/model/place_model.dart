import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel{

  final int id ;
  final String name ;
  final LatLng latLng ;

  PlaceModel({required this.id, required this.name, required this.latLng});





}
List<PlaceModel> places = [
  PlaceModel(id: 1, name: 'Tolip Hotel', latLng: const LatLng(31.232110612952468, 29.946100789340026)),
  PlaceModel(id: 2, name: 'Sediy Gaber Station', latLng: const LatLng(31.220000217871803, 29.941729018669385)),
  PlaceModel(id: 3, name: 'Four Seasons Hotel', latLng: const LatLng(31.246114612685993, 29.966297139036257)),
  PlaceModel(id: 4, name: 'Balbaa Restaurant', latLng: const LatLng(31.25611619866536, 29.990003220491054)),
  PlaceModel(id: 5, name: 'عزبة سكينة', latLng: const LatLng(31.21255089602546, 29.992310097388717)),
];