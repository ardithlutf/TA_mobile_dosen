class ItemModelUser {
  List<_User> _results = [];

  ItemModelUser.fromJson(Map<String, dynamic> parsedJson) {
    List<_User> temp = [];

    for (int i = 0; i < parsedJson['results'].length; i++) {
      _User result = _User(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<_User> get results => _results;
}

class ItemModelUserProfile {
  List<_User> _results = [];

  ItemModelUserProfile.fromJson(Map<String, dynamic> parsedJson) {
    List<_User> temp = [];

    _User result = _User(parsedJson['results']);
    temp.add(result);
    _results = temp;
  }

  List<_User> get results => _results;
}

class _User {
  int _id;
  String _nama;
  String _role;
  String _username;
  String _email;
  String _foto;
  String _noHp;

  _User(result) {
    _id = result['id'];
    _nama = result['nama'];
    _role = result['role'];
    _username = result['username'];
    _email = result['email'];
    _foto = result['foto'];
    _noHp = result['no_hp'];
  }

  int get id => _id;
  String get nama => _nama;
  String get role => _role;
  String get username => _username;
  String get email => _email;
  String get foto => _foto;
  String get noHp => _noHp;
}
