class Chicks {
  int? id;
  String? ringNumber;
  String? photo;
  String? dateOfBirth;
  String? gender;
  String? canaryType;

  Chicks({
    this.id,
    this.ringNumber,
    this.photo,
    this.dateOfBirth,
    this.gender,
    this.canaryType,
  });

  factory Chicks.fromJson(Map<String, dynamic> json) {
    return Chicks(
      id: json['id'],
      ringNumber: json['ring_number'],
      photo: json['photo'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      canaryType: json['canary_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ring_number': ringNumber,
      'photo': photo,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'canary_type': canaryType,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ring_number': ringNumber,
      'photo': photo,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'canary_type': canaryType,
    };
  }
}
