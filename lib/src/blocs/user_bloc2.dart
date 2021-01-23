// import 'package:bloc/bloc.dart';
// import 'package:lima_enam/src/models/user_model.dart';
// import 'package:lima_enam/src/resources/auth/api_auth_repository.dart';
//
// abstract class DashboardUserState {}
//
// class DashboardUserInitial extends DashboardUserState {}
//
// class DashboardUserLoading extends DashboardUserState {}
//
// class DashboardUserFailure extends DashboardUserState {
//   final String error;
//
//   DashboardUserFailure(this.error);
// }
//
// class DashboardUserSuccess extends DashboardUserState {
//   final List<ItemModelUser> users;
//
//   DashboardUserSuccess(this.users);
// }
//
// class DashboardUserEvent {}
//
// class DashboardUserBloc extends Bloc<DashboardUserEvent, DashboardUserState> {
//   final ApiAuthRepository apiAuthRepository = ApiAuthRepository();
//
//   @override
//   DashboardUserState get initialState => DashboardUserInitial();
//
//   @override
//   Stream<DashboardUserState> mapEventToState(DashboardUserEvent event) async* {
//     yield DashboardUserLoading();
//     ItemModelUser user =  await apiAuthRepository.fetchAllUsers();
//     if (user.error != null) {
//       yield DashboardUserFailure(user.error);
//       return;
//     }
//     yield DashboardUserSuccess(user.users);
//   }
//
// }
