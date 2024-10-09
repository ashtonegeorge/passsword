import "sword_model.dart";

// class representation of a folder object
class Sheath {
  final int? id;
  final String name;

  Sheath({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
    };
  }

  static Sheath fromMap(Map<String, dynamic> map) {
    return Sheath(
      id: map['id'],
      name: map['name'],
    );
  }
}