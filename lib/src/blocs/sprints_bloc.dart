import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/sprint_model.dart';

class SprintsBloc {
  final _repository = Repository();
  final _sprintsFetcher = PublishSubject<ItemModelSprint>();

  final _id = BehaviorSubject<int>();
  final _nama_sprint = BehaviorSubject<String>();
  final _desc_sprint = BehaviorSubject<String>();
  final _tgl_mulai = BehaviorSubject<String>();
  final _tgl_selesai = BehaviorSubject<String>();

  Observable<ItemModelSprint> get allSprints => _sprintsFetcher.stream;

  Function(String) get insertJudul => _nama_sprint.sink.add;
  Function(String) get insertDesc => _desc_sprint.sink.add;
  Function(String) get insertTglMulai => _tgl_mulai.sink.add;
  Function(String) get insertTglSelesai => _tgl_selesai.sink.add;

  fetchAllSprints() async {
    ItemModelSprint itemModel = await _repository.fetchAllSprints();
    _sprintsFetcher.sink.add(itemModel);
  }

  addSaveSprint() {
    _repository.createNewSprint(_nama_sprint.value, _desc_sprint.value, _tgl_mulai.value, _tgl_selesai.value);
  }

  deleteSprint(_id) {
    _repository.deleteOldSprint(_id);
  }

  dispose() {
    _sprintsFetcher.close();
    _id.close();
    _nama_sprint.close();
  }
}

final blocSprint = SprintsBloc();