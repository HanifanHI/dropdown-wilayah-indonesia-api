class KelurahanModel {
  String id;
  String idKecamatan;
  String name;

  KelurahanModel({
    required this.id,
    required this.idKecamatan,
    required this.name,
  });

  factory KelurahanModel.fromJson(Map<String, dynamic> json) {
    return KelurahanModel(
      id: json['id'],
      idKecamatan: json['id_kecamatan'],
      name: json['name'],
    );
  }

  @override
  String toString() => name;
}
