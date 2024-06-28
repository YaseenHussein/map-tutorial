import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_test/utils/location_service.dart';

class TrackingMyLocation extends StatefulWidget {
  const TrackingMyLocation({super.key});

  @override
  State<TrackingMyLocation> createState() => _TrackingMyLocationState();
}

class _TrackingMyLocationState extends State<TrackingMyLocation> {
  late Location location;
  late LocationService locationService;
  bool isFirstCall = true;
  @override
  void initState() {
    location = Location();
    locationService = LocationService();
    updateMyLocation();

    super.initState();
  }

  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(13.591621705736936, 44.05831241347871),
    zoom: 1,
  );
  Set<Marker> markers = {};
  GoogleMapController? googleMapController;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      // zoomControlsEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition: initialCameraPosition,
      onMapCreated: (controller) async {
        googleMapController = controller;
        //  initialMapStyle();
      },
    );
  }

  void initialMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString("asset/map_style/night.json");
    googleMapController!.setMapStyle(nightMapStyle);
  }

  void getLocationData() {}
  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();
    await locationService.checkAndRequestLocationPermission().then((value) {
      if (value) {
        locationService.location.changeSettings(distanceFilter: 5);
        //هنا لن يحصل التغيير الا على 5 متر

        locationService.getRealTimeLocationData(onData: (locationData) {
          LatLng latLng = LatLng(
            locationData.latitude!,
            locationData.longitude!,
          );

          setMyLocationMarker(latLng);
          updateCamera(latLng);
        });

        ///ملاحظة هذا سوف يجب لنا خطاء في حال عدم الحصول على الصلاحية لذلك يجب التحقق من ان الزبون اعطاء الصلاحية حق الموقع ام لا
        //Throws an error if the app has no permission to access location.
      } else {}
    });
  }

  void updateCamera(LatLng latLng) {
    if (isFirstCall) {
      CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 17);
      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
      isFirstCall = false;
    } else {
      googleMapController?.animateCamera(
        CameraUpdate.newLatLng(latLng),
      );
    }
  }

  void setMyLocationMarker(LatLng latLng) {
    Marker marker = Marker(
      markerId: const MarkerId("my_location_marker"),
      position: latLng,
    );
    markers.add(marker);
    setState(() {});
  }
}

//       0      //
//وهم خطوة هي هل تم تفعيب الموقع
//location services
////هذه النقطة ماينفعش نتعديها بسبب انه اذا هذا الخدمة موش شالة ماينفعش نعمل باقي الخطوات اي هذا اهم خطوة
//اين نتاكد من انه الخدمة مفعل
//inquire about location service
//       1      //
//اول شي نطلب الصلاحية من المستخدم
//request permission

//       2     //
//جلب موقع المستخدم
//get user Location
//       3    ///
//عرض الموقع
//display
