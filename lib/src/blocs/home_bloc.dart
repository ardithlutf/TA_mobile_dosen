import 'authorization_bloc.dart';

class HomeBloc {
  logoutUser() {
    authBloc.closeSession();
  }
}