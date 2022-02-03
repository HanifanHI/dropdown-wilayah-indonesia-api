class CityModel {
  String id;
  String idProvince;
  String name;

  CityModel({
    required this.id,
    required this.idProvince,
    required this.name,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      idProvince: json['id_provinsi'],
      name: json['name'],
    );
  }
  @override
  String toString() => name;
}
