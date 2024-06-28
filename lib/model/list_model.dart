import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLong;

  PlaceModel(this.id, this.name, this.latLong);
}

List<PlaceModel> places = [
  PlaceModel(
    1,
    "UST",
    const LatLng(
      13.591637007669124,
      44.05831824822032,
    ),
  ),
  PlaceModel(
    2,
    "TaizUST",
    const LatLng(
      13.619149079840115,
      44.09836952452197,
    ),
  ),
  PlaceModel(
    3,
    "الحكمة",
    const LatLng(
      13.603269481202789,
      44.07323443728196,
    ),
  ),
];
