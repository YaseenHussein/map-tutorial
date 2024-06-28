import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_test/model/list_model.dart';
import 'dart:ui' as ui;

import 'package:map_test/loction_tracking.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        // useMaterial3: true,
      ),
      home: const TestGoogleMap(),
    );
  }
}

class TestGoogleMap extends StatelessWidget {
  const TestGoogleMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Location location = Location();
          LocationData locationData = await location.getLocation();
          print("${locationData.latitude},${locationData.longitude}");
        },
        child: const Icon(Icons.location_on),
      ),
      body: const TrackingMyLocation(),
    );
  }
}

class CustomGooglMap extends StatefulWidget {
  const CustomGooglMap({
    super.key,
  });

  @override
  State<CustomGooglMap> createState() => _CustomGoogleMap();
}

class _CustomGoogleMap extends State<CustomGooglMap> {
  late CameraPosition
      initialCameraPositron; //هذا يضهر في البدئية ولا يمكن تغيرة حيث يتم التحكم به عن طريق الكنترولار
  late GoogleMapController googleMapController;
  @override
  void initState() {
    // TODO: implement initState
    initialCameraPositron = const CameraPosition(
        target: LatLng(13.591637007669124, 44.05831824822032), zoom: 15);
    // initialMark();
    // initCircles();
    //initPolyLines();
    //initPolygon(); //رسم التضليل او الشكل
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

//the marker should be type of set
  Set<Marker> marker = {};
  //the polylines should be type of set
  Set<Polyline> polylines = {}; //الخطوط
  //the polylines should be type of set
  Set<Polygon> polygons = {}; //التضليل
  Set<Circle> circles = {};
  String? nightMapStyle;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      style: nightMapStyle,
      zoomControlsEnabled: true, //الغاء مكان زيادة وانقاص
      polylines: polylines,

      polygons: polygons,
      // mapType:
      //     MapType.hybrid, //عند كاتبة هذه سوف يتعامس الاستايل الخاص بالخريطة
      markers: marker,
      circles: circles,
      onMapCreated: (controller) {
        googleMapController = controller;
        initialMapstyle();
      },
      initialCameraPosition: initialCameraPositron,
    );
  }

  void initialMapstyle() async {
    // هنا سحبنا التصميم حق الخريطة حيث انه الخريطة مصممه في ملف جسون
    nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString("asset/map_style/night.json");
    googleMapController.setMapStyle();
    //سحب التصميم
  }

  initPolyLines() {
    Polyline polyline = const Polyline(
      polylineId: PolylineId('1'),
      color: Colors.red,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      patterns: [PatternItem.dot], //شكل الخط منقط
      width: 5,
      zIndex: 3, //طبقة ضهور الخط
      points: [
        LatLng(13.591621091028127, 44.058302942677926),
        LatLng(13.590603666553069, 44.05800267565474),
        LatLng(13.590797296516119, 44.05690499914198),
        LatLng(13.591109475102993, 44.05670172571368),
        LatLng(13.591145039726037, 44.05669766024511),
        LatLng(13.59346628170413, 44.05912320736759),
        LatLng(13.598356460362588, 44.06181613019868),
      ],
    );
    //   Polyline polyline1 = const Polyline(
    //     polylineId: PolylineId('1'),
    //     color: Colors.green,
    //     startCap: Cap.roundCap,
    //     endCap: Cap.roundCap,
    //     width: 5,
    //     zIndex: 2, //طبقة ضهور الخط
    //     points: [
    //       LatLng(13.59281829591614, 44.05977410915324),
    //       LatLng(13.593798556548126, 44.05695242525024),
    //       LatLng(13.593798556548126, 44.05695242525024),
    //       LatLng(13.590313178924632, 44.05826275346952),
    //     ],
    //   );
    //   Polyline bigOolyline = const Polyline(
    //     polylineId: PolylineId('1'),
    //     geodesic:
    //         true, //يتم استخدام هذه الخاصية عندما يكةن الخط طويل جداَ ونحن نريد ان نضهرها بشكل مقوس حسب الكرة الارضيه بسبب ان الكرة الارضية مقوس
    //     color: Colors.blue,
    //     startCap: Cap.roundCap,
    //     endCap: Cap.roundCap,
    //     width: 10,

    //     points: [
    //       LatLng(-33.06252908772952, 49.0356560748773),
    //       LatLng(76.94626842392258, -120.59331023378694),
    //     ],
    //   );

    //   polylines.addAll({polyline, polyline1, bigOolyline});
    // }

    initCircles() {
      Circle circle = Circle(
        circleId: const CircleId('1'),
        center: const LatLng(13.591038268721237, 44.05654858268791),
        radius: 200,
        strokeColor: Colors.blue.shade300,
        strokeWidth: 2,
        fillColor: const Color.fromARGB(56, 252, 228, 236),
      );

      circles.add(circle);
    }

    // initPolygon() {
    //   Polygon polygon = const Polygon(
    //     polygonId: PolygonId("1"),
    //     fillColor: Color.fromARGB(77, 242, 90, 79),
    //     strokeColor: Color.fromARGB(193, 112, 112, 221),
    //     strokeWidth: 2,
    //     holes: [
    //       //holes Polygon
    //       [
    //         LatLng(13.594757947428501, 43.99781587433187),
    //         LatLng(13.549259757471749, 43.99961106699233),
    //         LatLng(13.605885291401359, 43.9889694143672),
    //         LatLng(13.59678113976248, 44.044129694146925),
    //         LatLng(13.558337533387594, 44.06182261407627),
    //       ],
    //     ],
    //     points: [
    //       LatLng(13.691346054718725, 44.12687011381651),
    //       LatLng(13.66859325518912, 44.13467581378534),
    //       LatLng(13.633701362265299, 44.12166631383729),
    //       LatLng(13.610943002150595, 44.0935657939495),
    //       LatLng(13.553784588735681, 44.14196113375624),
    //       LatLng(13.50217846014835, 44.05974109408458),
    //       LatLng(13.565419718307714, 43.93849255456877),
    //       LatLng(13.613471816990508, 43.92444229462488),
    //       LatLng(13.657468864296312, 44.01550879426122),
    //       LatLng(13.687806874817166, 44.07847477400977),
    //     ],
    //   );
    //   polygons.addAll({polygon});
    // }

    Future<Uint8List> getImageFromRawDate(
        {required String img, required double width}) async {
      var imgData = await rootBundle.load(img);
      var imageCode = await ui.instantiateImageCodec(
          imgData.buffer.asUint8List(),
          targetWidth: width.round());
      var imageFrameInfo = await imageCode.getNextFrame();
      var imageByData =
          await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);
      return imageByData!.buffer.asUint8List();
    }

    void initialMark() async {
      // var myMarker = Marker(
      //     markerId: MarkerId("1"),
      //     position: LatLng(
      //       13.591637007669124,
      //       44.05831824822032,
      //     ));
      // marker.add(myMarker);

      var markerIcon = BitmapDescriptor.fromBytes(
          await getImageFromRawDate(img: "asset/images/img2.png", width: 250));
      var myMarker = places
          .map((e) => Marker(
                icon: markerIcon,
                infoWindow: InfoWindow(title: e.name, snippet: e.name),
                //  icon: markerIcon,
                markerId: MarkerId(
                  e.id.toString(),
                ),
                position: e.latLong,
              ))
          .toSet();
      marker.addAll(myMarker);
      setState(() {});
    }
  }
}
