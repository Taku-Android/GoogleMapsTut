import 'package:flutter/material.dart';
import 'package:google_maps_tut/widgets/custom_google_maps.dart';

void main() {
  runApp(const GoogleMapsTut());
}

class GoogleMapsTut extends StatelessWidget {
  const GoogleMapsTut({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CustomGoogleMaps(),
    );
  }
}

