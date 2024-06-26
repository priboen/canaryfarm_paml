// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Breeder {
  int? id;
  int userId;
  String name;
  String address;
  String photo;
  String phone;
  Breeder({
    this.id,
    required this.userId,
    required this.name,
    required this.address,
    required this.photo,
    required this.phone,
  });
  

  Breeder copyWith({
    int? id,
    int? userId,
    String? name,
    String? address,
    String? photo,
    String? phone,
  }) {
    return Breeder(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      address: address ?? this.address,
      photo: photo ?? this.photo,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'name': name,
      'address': address,
      'photo': photo,
      'phone': phone,
    };
  }

  factory Breeder.fromMap(Map<String, dynamic> map) {
    return Breeder(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['user_id'] as int,
      name: map['name'] as String,
      address: map['address'] as String,
      photo: map['photo'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Breeder.fromJson(String source) => Breeder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Breeder(id: $id, userId: $userId, name: $name, address: $address, photo: $photo, phone: $phone)';
  }

  @override
  bool operator ==(covariant Breeder other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userId == userId &&
      other.name == name &&
      other.address == address &&
      other.photo == photo &&
      other.phone == phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      name.hashCode ^
      address.hashCode ^
      photo.hashCode ^
      phone.hashCode;
  }
}
