class BirdParent {
  int? id;
  String? ringNumber;
  String? photo;
  double? price;
  String? dateOfBirth;
  String? gender;
  String? canaryType;
  String? typeDescription;

  BirdParent({
    this.id,
    this.ringNumber,
    this.photo,
    this.price,
    this.dateOfBirth,
    this.gender,
    this.canaryType,
    this.typeDescription,
  });

  factory BirdParent.fromJson(Map<String, dynamic> json) {
    return BirdParent(
      id: json['id'],
      ringNumber: json['ring_number'] ??
          '', // Pastikan nilai default untuk menghindari null
      photo: json['photo'] ?? '',
      price: (json['price'] != null)
          ? double.parse(json['price'].toString())
          : 0.0,
      dateOfBirth: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? '',
      canaryType: json['canary_type'] ?? '',
      typeDescription: json['type_description'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ring_number': ringNumber,
      'photo': photo,
      'price': price,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'canary_type': canaryType,
      'type_description': typeDescription,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ring_number': ringNumber,
      'photo': photo,
      'date_of_birth': dateOfBirth,
      'canary_type': canaryType,
    };
  }
}
