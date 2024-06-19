// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Profile {
  int? id;
  final String username;
  final String name;
  final String address;
  final String phone;
  final String photo;
  Profile({
    this.id,
    required this.username,
    required this.name,
    required this.address,
    required this.phone,
    required this.photo,
  });

  Profile copyWith({
    int? id,
    String? username,
    String? name,
    String? address,
    String? phone,
    String? photo,
  }) {
    return Profile(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'name': name,
      'address': address,
      'phone': phone,
      'photo': photo,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] != null ? map['id'] as int : null,
      username: map['username'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      photo: map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(id: $id, username: $username, name: $name, address: $address, phone: $phone, photo: $photo)';
  }

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.name == name &&
        other.address == address &&
        other.phone == phone &&
        other.photo == photo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        name.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        photo.hashCode;
  }
}
