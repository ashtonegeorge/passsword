// class representation of a password object
class Sword {
  String _name = "None";
  String _description = "None";
  String _type = "None";
  String _url = "None";

  Sword({required n, d = "None", required t, u = "None"}) {
    _name = n;
    _description = d;
    _type = t;
    _url = u;
  }

  String getName() { return _name; }
  String getDescription() { return _description; }
  String getType() { return _type; }
  String getUrl() { return _url; }

  void setName(String name) { _name = name; }
  void setDescription(String description) { _description = description; }
  void setType(String type) { _type = type; }
  void setUrl(String url) { _url = url; }

}