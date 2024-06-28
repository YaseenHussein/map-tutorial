import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestGoogleMap extends StatelessWidget {
  const TestGoogleMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        centerTitle: true,
      ),
      body: const CustomGooglMap(),
    );
  }
}

class CustomGooglMap extends StatefulWidget {
  const CustomGooglMap({
    super.key,
  });

  @override
  State<CustomGooglMap> createState() => _CustomGooglMapState();
}

class _CustomGooglMapState extends State<CustomGooglMap> {
  late CameraPosition
      initialCameraPositron; //هذا يضهر في البدئية ولا يمكن تغيرة حيث يتم التحكم به عن طريق الكنترولار
  late GoogleMapController googleMapController;
  @override
  void initState() {
    // TODO: implement initState
    initialCameraPositron = const CameraPosition(
        target: LatLng(13.598254186554492, 44.061779971534705), zoom: 20);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          
          cameraTargetBounds: CameraTargetBounds(
            //هنا حددنا من الخريطة اي لن يتم الخروج من الاطار المكان الذي نحن حددناه
            LatLngBounds(
              northeast: const LatLng(13.924126729793198, 44.295846838239164),
              southwest: const LatLng(13.584049913697957, 44.04503334049996),
            ),
          ),
          onMapCreated: (controller) {
            googleMapController = controller;
          },
          mapType: MapType.hybrid,
          initialCameraPosition: initialCameraPositron,
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () {
              // CameraPosition cameraPosition = const CameraPosition(
              //   zoom: 20,
              //   target: LatLng(
              //     13.598356760464894,
              //     44.06178669752518,
              //   ),
              // );
              // googleMapController.animateCamera(
              //     CameraUpdate.newCameraPosition(cameraPosition));
              //هذا يعني انه يوجد العديد من الدوالت التي يمكن استخدامها لتحكم بالكمارة الخاصة بالخريطة

              googleMapController.animateCamera(
                CameraUpdate.newLatLng(
                  const LatLng(
                    13.598356760464894,
                    44.06178669752518,
                  ),
                ),
              );
            },
            child: const Text("change location"),
          ),
        ),
      ],
    );
  }
}
//use zoom
// world 0->3
//country view 4->6
//city view 10->12
//street view 13->17
//building view 18->20