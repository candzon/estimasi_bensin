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
