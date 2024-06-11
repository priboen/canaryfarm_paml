// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Profie {
  final String username;
  final String name;
  final String address;
  final String phone;
  final String photo;
  Profie({
    required this.username,
    required this.name,
    required this.address,
    required this.phone,
    required this.photo,
  });

  Profie copyWith({
    String? username,
    String? name,
    String? address,
    String? phone,
    String? photo,
  }) {
    return Profie(
      username: username ?? this.username,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'name': name,
      'address': address,
      'phone': phone,
      'photo': photo,
    };
  }

  factory Profie.fromMap(Map<String, dynamic> map) {
    return Profie(
      username: map['username'] as String,
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
    return 'Profie(username: $username, name: $name, address: $address, phone: $phone, photo: $photo)';
  }

  @override
  bool operator ==(covariant Profie other) {
    if (identical(this, other)) return true;
  
    return 
      other.username == username &&
      other.name == name &&
      other.address == address &&
      other.phone == phone &&
      other.photo == photo;
  }

  @override
  int get hashCode {
    return username.hashCode ^
      name.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      photo.hashCode;
  }
}
