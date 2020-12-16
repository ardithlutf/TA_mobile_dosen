class ItemModelTask {
  List<_Task> _results = [];

  ItemModelTask.fromJson(Map<String, dynamic> parsedJson) {
    // print(parsedJson['results'].length);

    List<_Task> temp = [];

    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Task result = _Task(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<_Task> get results => _results;
}

class _Task {
  int _id;
  int _sprintID;
  String _namaTask;
  int _kesulitanID;
  bool _status;

  _Task(result) {
    _id = result['id'];
    _sprintID = result['sprint_id'];
    _namaTask = result['nama_task'];
    _kesulitanID = result['kesulitan_id'];
    _status = result['_status'];
  }

  int get id => _id;
  int get sprintID => _sprintID;
  String get namaTask => _namaTask;
  int get kesulitanID => _kesulitanID;
  bool get status => _status;
}
