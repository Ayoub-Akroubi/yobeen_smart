// ignore_for_file: non_constant_identifier_names

class LastDataModel {
  final String sensors_name;
  final String sensors_slug;
  final String sensors_unity;
  final String sensors_color;
  final String sensors_icon;
  final String value;

  LastDataModel(
      {required this.sensors_name,
      required this.sensors_slug,
      required this.sensors_unity,
      required this.sensors_color,
      required this.sensors_icon,
      required this.value});

  factory LastDataModel.fromJson(Map<String, dynamic> json) {
    return LastDataModel(
      sensors_name: json["name"],
      sensors_slug: json["slug"],
      sensors_unity: json["unity"],
      sensors_icon: json["icon"],
      sensors_color: json["color"],
      value: json["value"],
    );
  }
}
