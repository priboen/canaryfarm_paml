import 'dart:convert';

class Profie {
  int? id;
  final String name;
  final String address;
  final String phone;
  final String photo;
  Profie({
    this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.photo,
  });

  Profie copyWith({
    int? id,
    String? name,
    String? address,
    String? phone,
    String? photo,
  }) {
    return Profie(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'photo': photo,
    };
  }

  factory Profie.fromMap(Map<String, dynamic> map) {
    return Profie(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      photo: map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profie.fromJson(String source) =>
      Profie.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profie(id: $id, name: $name, address: $address, phone: $phone, photo: $photo)';
  }

  @override
  bool operator ==(covariant Profie other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.address == address &&
      other.phone == phone &&
      other.photo == photo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      photo.hashCode;
  }
}
