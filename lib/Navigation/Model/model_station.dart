// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

class StationModel {
  late dynamic serial;
  late dynamic name_fr;
  late dynamic x;
  late dynamic y;

  StationModel(
      {required this.serial,
      required this.name_fr,
      required this.x,
      required this.y});
  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      serial: json["serial"],
      name_fr: json["name_fr"],
      x: json["x"],
      y: json["y"],
    );
  }
}
