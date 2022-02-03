class KecamatanModel {
  String id;
  String idCity;
  String name;

  KecamatanModel({
    required this.id,
    required this.idCity,
    required this.name,
  });

  factory KecamatanModel.fromJson(Map<String, dynamic> json) {
    return KecamatanModel(
      id: json['id'],
      idCity: json['id_kabupaten'],
      name: json['name'],
    );
  }

  @override
  String toString() => name;
}
