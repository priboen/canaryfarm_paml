// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Status {
  int? id;
  String? name;
  Status({
    this.id,
    this.name,
  });

  Status copyWith({
    int? id,
    String? name,
  }) {
    return Status(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Status.fromJson(String source) =>
      Status.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Status(id: $id, name: $name)';

  @override
  bool operator ==(covariant Status other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
