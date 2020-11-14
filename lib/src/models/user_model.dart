class ItemModelUser {
  List<_User> _results = [];

  ItemModelUser.fromJson(Map<String, dynamic> parsedJson){
    List<_User> temp = [];

    for(int i = 0; i < parsedJson['results'].length; i++){
      _User result = _User(parsedJson['results'][i]);
      temp.add(result);
    }
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
  String _no_hp;
  int _fingerprint_pin;
  String _remember_token;

  _User(result){
    _id = result['id'];
    _nama = result['nama'];
    _role = result['role'];
    _username = result['username'];
    _email = result['email'];
    _foto = result['foto'];
    _no_hp = result['no_hp'];
    _fingerprint_pin = result['fingerprint_pin'];
    _remember_token = result['remember_token'];
  }

  int get id => _id;
  String get nama => _nama;
  String get role => _role;
  String get username => _username;
  String get email => _email;
  String get foto => _foto;
  String get no_hp => _no_hp;
  int get fingerprint_pin => _fingerprint_pin;
  String get remember_token => _remember_token;
}