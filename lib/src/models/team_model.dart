class ItemModelTeam {
  List<_Team> _results = [];

  ItemModelTeam.fromJson(Map<String, dynamic> parsedJson){
    List<_Team> temp = [];

    for(int i = 0; i < parsedJson['results'].length; i++){
      _Team result = _Team(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<_Team> get results => _results;
}

class _Team {
  int _id;
  String _nama;
  String _semester;
  String _prodi;
  String _nilai;
  int _scrumMasterId;
  int _projectId;

  _Team(result){
    _id = result['id'];
    _nama = result['nama'];
    _semester = result['semester'];
    _prodi = result['prodi'];
    _nilai = result['nilai'];
    _scrumMasterId = result['scrumMasterId'];
    _projectId = result['projectId'];
  }

  int get id => _id;
  String get nama => _nama;
  String get semester => _semester;
  String get prodi => _prodi;
  String get nilai => _nilai;
  int get scrumMasterId => _scrumMasterId;
  int get projectId => _projectId;
}