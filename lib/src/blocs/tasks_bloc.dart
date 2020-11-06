import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/task_model.dart';

class TasksBloc {
  final _repository = Repository();
  final _tasksFetcher = PublishSubject<ItemModelTask>();

  final _id = BehaviorSubject<int>();
  final _sprint_id = BehaviorSubject<int>();
  final _nama_task = BehaviorSubject<String>();
  final _kesulitan_id = BehaviorSubject<int>();
  final _status = BehaviorSubject<bool>();

  Observable<ItemModelTask> get allTasks => _tasksFetcher.stream;
  Observable<ItemModelTask> get sprintTasks => _tasksFetcher.stream;

  Function(int) get insertSprintID => _sprint_id.sink.add;
  Function(String) get insertJudul => _nama_task.sink.add;
  Function(int) get insertKesulitanID => _kesulitan_id.sink.add;
  Function(bool) get insertStatus => _status.sink.add;

  fetchAllTasks() async {
    ItemModelTask itemModel = await _repository.fetchAllTasks();
    _tasksFetcher.sink.add(itemModel);
  }

  addSaveTask() {
    _repository.createNewTask(_sprint_id.value, _nama_task.value, _kesulitan_id.value, _status.value);
  }

  deleteTask(_id) {
    _repository.deleteOldTask(_id);
  }

  dispose() {
    _tasksFetcher.close();
    _id.close();
    _nama_task.close();
  }
}

final blocTask = TasksBloc();