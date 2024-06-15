class BirdParent {
  int id;
  String ringNumber;
  String photo;
  double price;
  String dateOfBirth;
  String gender;
  String canaryType;
  String typeDescription;

  BirdParent({
    required this.id,
    required this.ringNumber,
    required this.photo,
    required this.price,
    required this.dateOfBirth,
    required this.gender,
    required this.canaryType,
    required this.typeDescription,
  });

  factory BirdParent.fromJson(Map<String, dynamic> json) {
    return BirdParent(
      id: json['id'],
      ringNumber: json['ring_number'],
      photo: json['photo'],
      price: double.parse(json['price']),
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      canaryType: json['canary_type'],
      typeDescription: json['type_description'],
    );
  }
}
