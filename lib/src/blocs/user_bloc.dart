import 'package:lima_enam/src/models/user_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';


class UsersBloc {
  final _repository = Repository();
  final _usersFetcher = PublishSubject<ItemModelUser>();

  final _id = BehaviorSubject<int>();
  final _nama = BehaviorSubject<String>();
  final _role = BehaviorSubject<String>();

  Observable<ItemModelUser> get allUsers => _usersFetcher.stream;

  fetchAllUsers() async {
    ItemModelUser itemModel = await _repository.fetchAllUsers();
    _usersFetcher.sink.add(itemModel);
  }

  fetchUserProfile() async {
    ItemModelUser itemModel = await _repository.fetchUserProfile();
    _usersFetcher.sink.add(itemModel);
  }

  dispose() {
    _usersFetcher.close();
    _id.close();
    _role.close();
    _nama.close();
  }
}

final blocUser = UsersBloc();