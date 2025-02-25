class Personalisasi {
  int id;
  int userId;
  bool diabetes;
  bool lambung;
  bool obesitas;
  bool jantung;
  bool rendahKarbohidrat;
  bool tinggiProtein;
  bool vegetarian;
  bool rendahGula;
  bool rendahKalori;
  DateTime? createdAt;
  DateTime? updatedAt;

  Personalisasi({
    this.id = 0,
    this.userId = 0,
    this.diabetes = false,
    this.lambung = false,
    this.obesitas = false,
    this.jantung = false,
    this.rendahKarbohidrat = false,
    this.tinggiProtein = false,
    this.vegetarian = false,
    this.rendahGula = false,
    this.rendahKalori = false,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to create a Personalisasi from a JSON map
  factory Personalisasi.fromJson(Map<String, dynamic> json) {
    return Personalisasi(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      diabetes: json['diabetes'] ?? false,
      lambung: json['lambung'] ?? false,
      obesitas: json['obesitas'] ?? false,
      jantung: json['jantung'] ?? false,
      rendahKarbohidrat: json['rendah_karbohidrat'] ?? false,
      tinggiProtein: json['tinggi_protein'] ?? false,
      vegetarian: json['vegetarian'] ?? false,
      rendahGula: json['rendah_gula'] ?? false,
      rendahKalori: json['rendah_kalori'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  // Method to convert a Personalisasi instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'diabetes': diabetes,
      'lambung': lambung,
      'obesitas': obesitas,
      'jantung': jantung,
      'rendah_karbohidrat': rendahKarbohidrat,
      'tinggi_protein': tinggiProtein,
      'vegetarian': vegetarian,
      'rendah_gula': rendahGula,
      'rendah_kalori': rendahKalori,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
