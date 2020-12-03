class ItemModelProject {
  List<_Project> _results = [];

  ItemModelProject.fromJson(Map<String, dynamic> parsedJson) {
    List<_Project> temp = [];

    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Project result = _Project(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<_Project> get results => _results;
}

class _Project {
  int _id;
  String _nama;
  String _deskripsi;
  String _tanggalMulai;
  String _tanggalAkhir;
  int _jumlahSprint;
  String _budget;
  String _status;
  String _persen;
  String _productOwnerId;

  _Project(result) {
    _id = result['id'];
    _nama = result['nama'];
    _deskripsi = result['deskripsi'];
    _tanggalMulai = result['tanggal_mulai'];
    _tanggalAkhir = result['tanggal_akhir'];
    _jumlahSprint = result['jumlah_sprint'];
    _budget = result['budget'];
    _status = result['status'];
    _persen = result['persen'];
    _productOwnerId = result['product_owner_id'];
  }

  int get id => _id;
  String get nama => _nama;
  String get deskripsi => _deskripsi;
  String get tanggalMulai => _tanggalMulai;
  String get tanggalAkhir => _tanggalAkhir;
  int get jumlahSprint => _jumlahSprint;
  String get budget => _budget;
  String get status => _status;
  String get persen => _persen;
  String get productOwnerId => _productOwnerId;
}
