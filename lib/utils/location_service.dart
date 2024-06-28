import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<bool> checkAndRequestLocationService() async {
    bool isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      bool isClientEnableService = await location.requestService();
      if (!isClientEnableService) {
//show error Bar
//هنا سوف نكتيب الشئ الذ سوف يحدث اذا كانت الخدمة موش مفعل
        //Location server
        return false;
      }
    }
    return true;
  }

  Future<bool> checkAndRequestLocationPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied /*مرفوظ */) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted /*جاب الصلاحية */) {
        return false;
        //هنا سوف نكتيب الشئ الذ سوف يحدث اذا كانت  الصلاحية  لم يتم اعطائها
        //Location server
      }
    }
    return permissionStatus == PermissionStatus.granted;
  }

  void getRealTimeLocationData({
    required void Function(LocationData)? onData,
  }) {
    location.onLocationChanged.listen(onData);
    //هذه سوف تجيب لنا قناة من المواقع حسب التحرك
  }
}
