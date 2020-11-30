

import 'package:lima_enam/src/models/team_model.dart';
import 'package:lima_enam/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TeamsBloc {
  final _repository = Repository();
  final _teamsFetcher = PublishSubject<ItemModelTeam>();

  Observable<ItemModelTeam> get allTeams => _teamsFetcher.stream;

  fetchAllTeams() async {
    ItemModelTeam itemModel = await _repository.fetchAllTeams();
    _teamsFetcher.sink.add(itemModel);
  }

  dispose() {
    _teamsFetcher.close();
  }
}

final blocTeam = TeamsBloc();