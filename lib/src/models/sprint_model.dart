class ItemModelSprint {
  List<_Sprint> _results = [];

  ItemModelSprint.fromJson(Map<String, dynamic> parsedJson) {
    List<_Sprint> temp = [];

    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Sprint result = _Sprint(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<_Sprint> get results => _results;
}

class _Sprint {
  int _id;
  String _nama_sprint;
  String _desc_sprint;
  String _tgl_mulai;
  String _tgl_selesai;

  _Sprint(result) {
    _id = result['id'];
    _nama_sprint = result['nama_sprint'];
    _desc_sprint = result['desc_sprint'];
    _tgl_mulai = result['tgl_mulai'];
    _tgl_selesai = result['tgl_selesai'];
  }

  int get id => _id;
  String get nama_sprint => _nama_sprint;
  String get desc_sprint => _desc_sprint;
  String get tgl_selesai => _tgl_selesai;
  String get tgl_mulai => _tgl_mulai;
}