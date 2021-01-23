import 'package:lima_enam/src/models/sprint_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class SprintsBloc {
  final _repository = Repository();
  final _sprintsFetcher = PublishSubject<ItemModelSprint>();

  final _namaSprint = BehaviorSubject<String>();
  final _projectID = BehaviorSubject<int>();
  final _tglMulai = BehaviorSubject<String>();
  final _tglAkhir = BehaviorSubject<String>();
  final _status = BehaviorSubject<String>();

  Observable<ItemModelSprint> get allSprints => _sprintsFetcher.stream;

  Function(String) get insertNamaSprint => _namaSprint.sink.add;
  Function(int) get insertProjectID => _projectID.sink.add;
  Function(String) get insertTglMulai => _tglMulai.sink.add;
  Function(String) get insertTglAkhir => _tglAkhir.sink.add;
  Function(String) get insertStatus => _status.sink.add;

  fetchAllSprints() async {
    ItemModelSprint itemModel = await _repository.fetchAllSprints();
    _sprintsFetcher.sink.add(itemModel);
  }

  addSaveSprint() {
    _repository.createNewSprint(
        _projectID.value, _namaSprint.value, _tglMulai.value, _tglAkhir.value);
  }

  updateSaveSprint(_id) {
    _repository.updateSprint(_id, _projectID.value, _namaSprint.value,
        _tglMulai.value, _tglAkhir.value);
  }

  updateStatusSprint(_id) {
    _repository.updateStatusSprint(_id, _status.value);
  }

  deleteSprint(_id) {
    _repository.deleteOldProject(_id);
  }

  dispose() {
    _sprintsFetcher.close();
    _namaSprint.close();
    _projectID.close();
    _tglMulai.close();
    _tglAkhir.close();
    _status.close();
  }
}

final blocSprint = SprintsBloc();
