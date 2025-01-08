class Predict {
  final int? id;
  final double jarakTempuh;
  final double bahanBakar;
  final String merkKendaraan;
  final double estimasiBensin;
  final double totalBiaya;
  final String? photo;

  Predict({
    this.id,
    required this.jarakTempuh,
    required this.bahanBakar,
    required this.merkKendaraan,
    required this.estimasiBensin,
    required this.totalBiaya,
    this.photo,
  });

  factory Predict.fromJson(Map<String, dynamic> json) {
    return Predict(
      id: json['id'],
      jarakTempuh: json['jarakTempuh'],
      bahanBakar: json['bahanBakar'],
      merkKendaraan: json['merkKendaraan'],
      estimasiBensin: json['estimasiBensin'],
      totalBiaya: json['totalBiaya'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jarakTempuh': jarakTempuh,
      'bahanBakar': bahanBakar,
      'merkKendaraan': merkKendaraan,
      'estimasiBensin': estimasiBensin,
      'totalBiaya': totalBiaya,
      'photo': photo,
    };
  }
}