// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

class StationMapModel {
  late dynamic serial;
  late dynamic name_fr;
  late dynamic name_ar;
  late dynamic x;
  late dynamic y;
  late dynamic z;

  StationMapModel(
      {required this.serial,
      required this.name_fr,
      required this.name_ar,
      required this.x,
      required this.y,
      required this.z});
  factory StationMapModel.fromJson(Map<String, dynamic> json) {
    return StationMapModel(
      serial: json["serial"],
      name_fr: json["name_fr"],
      name_ar: json["name_ar"],
      x: json["x"],
      y: json["y"],
      z: json["z"],
    );
  }
}
