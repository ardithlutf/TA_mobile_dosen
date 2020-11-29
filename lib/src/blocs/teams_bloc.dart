

import 'package:lima_enam/src/models/team_model.dart';
import 'package:lima_enam/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TeamsBloc {
  final _repository = Repository();
  final _teamsFetcher = PublishSubject<ItemModelTeam>();

  // final _id = BehaviorSubject<int>();
  // final _nama = BehaviorSubject<String>();
  // final _semester = BehaviorSubject<String>();
  // final _prodi = BehaviorSubject<String>();
  // final _nilai = BehaviorSubject<String>();
  // final _scrumMasterId = BehaviorSubject<String>();
  // final _projectId = BehaviorSubject<String>();

  Observable<ItemModelTeam> get allTeams => _teamsFetcher.stream;

  fetchAllTeams() async {
    ItemModelTeam itemModel = await _repository.fetchAllTeams();
    _teamsFetcher.sink.add(itemModel);
  }


  dispose() {
    _teamsFetcher.close();
    // _id.close();
    // _nama.close();
    // _semester.close();
  }
}

final blocTeam = TeamsBloc();