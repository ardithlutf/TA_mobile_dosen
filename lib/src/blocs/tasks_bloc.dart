import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/task_model.dart';

class TasksBloc {
  final _repository = Repository();
  final _tasksFetcher = PublishSubject<ItemModelTask>();

  final _id = BehaviorSubject<int>();
  final _sprintID = BehaviorSubject<int>();
  final _namaTask = BehaviorSubject<String>();
  final _kesulitanID = BehaviorSubject<int>();
  final _status = BehaviorSubject<bool>();

  Observable<ItemModelTask> get allTasks => _tasksFetcher.stream;
  // Observable<ItemModelTask> get sprintTasks => _tasksFetcher.stream;

  Function(int) get insertSprintID => _sprintID.sink.add;
  Function(String) get insertJudul => _namaTask.sink.add;
  Function(int) get insertKesulitanID => _kesulitanID.sink.add;
  Function(bool) get insertStatus => _status.sink.add;

  fetchAllTasks() async {
    ItemModelTask itemModel = await _repository.fetchAllTasks();
    _tasksFetcher.sink.add(itemModel);
  }

  // addSaveTask() {
  //   _repository.createNewSprint(
  //       _sprintID.value, _namaTask.value, _kesulitanID.value, _status.value);
  // }

  updateSaveTask(_id) {
    _repository.updateTask(_id, _sprintID.value, _namaTask.value,
        _kesulitanID.value, _status.value);
  }

  deleteTask(_id) {
    _repository.deleteOldTask(_id);
  }

  dispose() {
    _tasksFetcher.close();
    _id.close();
    _sprintID.close();
    _namaTask.close();
    _kesulitanID.close();
    _status.close();
  }
}

final blocTask = TasksBloc();
