import 'package:royal_canary_farm_app/app/data/bird_parent.dart';

class Pedigree {
  int? id;
  int? parentId;
  int? relationsId;
  BirdParent? parent;

  Pedigree({this.id, this.parentId, this.relationsId, this.parent});

  factory Pedigree.fromJson(Map<String, dynamic> json) {
    return Pedigree(
      id: json['id'],
      parentId: json['parent_id'],
      relationsId: json['relations_id'],
      parent: json.containsKey('parent')
          ? BirdParent.fromJson(json['parent'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'relations_id': relationsId,
      'parent': parent?.toJson(),
    };
  }
}
