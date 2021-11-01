// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import "package:latlong2/latlong.dart" as latLng;

// class LocationPage extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           backgroundColor: Color(0x00000000),
//           bottomOpacity: 0,
//           elevation: 0.0,
//           shadowColor: Colors.white,
//           iconTheme: IconThemeData(
//             color: Colors.black, //change your color here
//           ),
//           //backgroundColor: Colors.white,
//         ),
//         body: FlutterMap(
//             options: MapOptions(
//               center: latLng.LatLng(50.4547, 30.5238),
//               zoom: 15.0,
//             ),
//             layers: [
//               TileLayerOptions(
//                   urlTemplate:
//                       "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                   subdomains: ['a', 'b', 'c']),
//               MarkerLayerOptions(
//                 markers: [
//                   Marker(
//                     width: 80.0,
//                     height: 80.0,
//                     point: latLng.LatLng(50.4547, 30.5238),
//                     builder: (ctx) => Container(
//                       child: Icon(Icons.place),
//                     ),
//                   ),
//                 ],
//               ),
//             ]));
//   }
// }
