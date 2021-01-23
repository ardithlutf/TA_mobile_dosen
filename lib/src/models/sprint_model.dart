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
  String _nama;
  String _projectId;
  String _tanggalMulai;
  String _tanggalAkhir;
  String _status;

  _Sprint(result) {
    _id = result['id'];
    _nama = result['nama'];
    _projectId = result['project_id'];
    _tanggalMulai = result['tanggal_mulai'];
    _tanggalAkhir = result['tanggal_akhir'];
    _status = result['status'];
  }

  int get id => _id;
  String get nama => _nama;
  String get projectId => _projectId;
  String get tanggalMulai => _tanggalMulai;
  String get tanggalAkhir => _tanggalAkhir;
  String get status => _status;
}
