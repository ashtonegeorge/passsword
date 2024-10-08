// class representation of a password object
class Sword {
  final int? id;
  final String type;
  final String name;
  final String username;
  final String password;
  final String securityPhrase;
  final int? sheathId;

  Sword({
    this.id,
    required this.type,
    required this.name,
    required this.username,
    required this.password,
    required this.securityPhrase,
    this.sheathId,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'username': username,
      'password': password,
      'securityPhrase': securityPhrase,
      'sheath_id': sheathId,
    };
  }

  static Sword fromMap(Map<String, dynamic> map) {
    return Sword(
      id: map['id'],
      type: map['type'],
      name: map['name'],
      username: map['username'],
      password: map['password'],
      securityPhrase: map['securityPhrase'],
      sheathId: map['sheath_id'],
    );
  }
}