import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/project_model.dart';

class ProjectsBloc {
  final _repository = Repository();
  final _projectsFetcher = PublishSubject<ItemModelProject>();

  Observable<ItemModelProject> get allSprints => _projectsFetcher.stream;

  fetchAllProjects() async {
    ItemModelProject itemModel = await _repository.fetchAllProjects();
    _projectsFetcher.sink.add(itemModel);
  }

  dispose() {
    _projectsFetcher.close();
  }
}

final blocProject = ProjectsBloc();
