// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Status {
  int? id;
  final String parentStatus;
  Status({
    this.id,
    required this.parentStatus,
  });

  Status copyWith({
    int? id,
    String? parentStatus,
  }) {
    return Status(
      id: id ?? this.id,
      parentStatus: parentStatus ?? this.parentStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'parentStatus': parentStatus,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      id: map['id'] != null ? map['id'] as int : null,
      parentStatus: map['parentStatus'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Status.fromJson(String source) =>
      Status.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Status(id: $id, parentStatus: $parentStatus)';

  @override
  bool operator ==(covariant Status other) {
    if (identical(this, other)) return true;

    return other.id == id && other.parentStatus == parentStatus;
  }

  @override
  int get hashCode => id.hashCode ^ parentStatus.hashCode;
}
