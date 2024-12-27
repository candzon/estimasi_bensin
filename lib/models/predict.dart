class Predict {
  final double jarakTempuh;
  final double bahanBakar;
  final String merkKendaraan;
  final double estimasiBensin;
  final double totalBiaya;
  final String? photo;

  Predict({
    required this.jarakTempuh,
    required this.bahanBakar,
    required this.merkKendaraan,
    required this.estimasiBensin,
    required this.totalBiaya,
    this.photo,
  });

  factory Predict.fromJson(Map<String, dynamic> json) {
    return Predict(
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
      'jarakTempuh': jarakTempuh,
      'bahanBakar': bahanBakar,
      'merkKendaraan': merkKendaraan,
      'estimasiBensin': estimasiBensin,
      'totalBiaya': totalBiaya,
      'photo': photo,
    };
  }
}