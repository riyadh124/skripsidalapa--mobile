class DataWorkorder {
  final int id;
  final int userId;
  final String nomorTiket;
  final String witel;
  final String sto;
  final String headline;
  final String lat;
  final String lng;
  final String status;
  final String evidenceBefore;
  final String evidenceAfter;
  final String createdAt;
  final String updatedAt;
  final String catatan;

  DataWorkorder({
    required this.id,
    required this.userId,
    required this.nomorTiket,
    required this.witel,
    required this.sto,
    required this.headline,
    required this.lat,
    required this.lng,
    required this.status,
    required this.evidenceBefore,
    required this.evidenceAfter,
    required this.createdAt,
    required this.updatedAt,
    required this.catatan,
  });

  factory DataWorkorder.fromJson(Map<String, dynamic> json) {
    return DataWorkorder(
        id: json['id'],
        userId: json['user_id'],
        nomorTiket: json['nomor_tiket'],
        witel: json['witel'],
        sto: json['sto'],
        headline: json['headline'],
        lat: json['lat'],
        lng: json['lng'],
        status: json['status'],
        evidenceBefore: json['evidence_before'] ?? '',
        evidenceAfter: json['evidence_after'] ?? '',
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        catatan: json['catatan'] ?? '');
  }
}
