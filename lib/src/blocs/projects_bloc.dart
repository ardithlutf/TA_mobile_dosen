import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/project_model.dart';

class ProjectsBloc {
  final _repository = Repository();
  final _sprintsFetcher = PublishSubject<ItemModelProject>();

  Observable<ItemModelProject> get allSprints => _sprintsFetcher.stream;

  fetchAllSprints() async {
    ItemModelProject itemModel = await _repository.fetchAllSprints();
    _sprintsFetcher.sink.add(itemModel);
  }

  dispose() {
    _sprintsFetcher.close();
  }
}

final blocSprint = ProjectsBloc();
