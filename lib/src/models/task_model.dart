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
  int _sprint_id;
  String _nama_task;
  int _kesulitan_id;
  bool _status;

  _Task(result) {
    _id = result['id'];
    _sprint_id = result['sprint_id'];
    _nama_task = result['nama_task'];
    _kesulitan_id = result['kesulitan_id'];
    _status = result['_status'];
  }

  int get id => _id;
  int get sprint_id => _sprint_id;
  String get nama_task => _nama_task;
  int get kesulitan_id => _kesulitan_id;
  bool get status => _status;
}