import 'package:lima_enam/src/models/sprint_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class SprintsBloc {
  final _repository = Repository();
  final _sprintsFetcher = PublishSubject<ItemModelSprint>();

  Observable<ItemModelSprint> get allSprints => _sprintsFetcher.stream;

  fetchAllSprints() async {
    ItemModelSprint itemModel = await _repository.fetchAllSprints();
    _sprintsFetcher.sink.add(itemModel);
  }

  deleteSprint(_id) {
    _repository.deleteOldSprint(_id);
  }

  dispose() {
    _sprintsFetcher.close();
  }
}

final blocSprint = SprintsBloc();
