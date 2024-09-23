class dataMaterial {
  final int id;
  final String name;
  final int? quantity;

  dataMaterial({required this.id, required this.name, this.quantity});

  factory dataMaterial.fromJson(Map<String, dynamic> json) {
    return dataMaterial(
      id: json['id'] ?? json['id_material'],
      name: json['nama'] ?? json['name'],
      quantity: json['quantity'] ?? 0,
    );
  }
}
