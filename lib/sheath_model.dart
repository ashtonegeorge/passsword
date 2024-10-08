import "sword_model.dart";

// class representation of a folder object
class Sheath {
  final int? id;
  final String name;
  final List<Sword>? swords;

  Sheath({
    this.id,
    required this.name,
    this.swords
  });

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'swords' : swords
    };
  }

  static Sheath fromMap(Map<String, dynamic> map) {
    return Sheath(
      id: map['id'],
      name: map['name'],
      swords: map['swords'],
    );
  }
}