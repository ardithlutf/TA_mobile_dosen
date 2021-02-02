import 'dart:async';

// provider
import 'package:lima_enam/src/models/sprint_model.dart';

import 'team_api_provider.dart';
import 'auth/auth_provider.dart';
import 'project_api_provider.dart';
import 'sprint_api_provider.dart';
import 'user_api_provider.dart';

// model
import '../models/team_model.dart';
import '../models/project_model.dart';
import '../models/user_model.dart';

class Repository {
  //AUTH
  final AuthProvider authProvider = AuthProvider();

  final usersApiProvider = UserApiProvider();
  final projectsApiProvider = ProjectApiProvider();
  final sprintsApiProvider = SprintApiProvider();
  final teamsApiProvider = TeamApiProvider();

  Future<String> login(String username, String password) =>
      authProvider.login(username: username, password: password);
  Future<String> loginUsers(String username, String password) =>
      usersApiProvider.loginUser(username, password);

  Future<ItemModelProject> fetchAllProjects() =>
      projectsApiProvider.fetchProjectList();
  Future<ItemModelSprint> fetchAllSprints() =>
      sprintsApiProvider.fetchSprintList();
  Future<ItemModelUser> fetchAllUsers() => usersApiProvider.fetchUserList();
  Future<ItemModelUserProfile> fetchUserProfile() =>
      usersApiProvider.fetchUserProfile();
  Future<ItemModelTeam> fetchAllTeams() => teamsApiProvider.fetchTeamList();

  // CRUD Sprint
  Future deleteOldProject(id) => sprintsApiProvider.deleteSprint(id);
  Future createNewSprint(projectID, namaSprint, tglMulai, tglAkhir) =>
      sprintsApiProvider.createNewSprint(
          projectID, namaSprint, tglMulai, tglAkhir);
  Future updateSprint(id, projectID, namaSprint, tglMulai, tglAkhir) =>
      sprintsApiProvider.updateSprint(
          id, projectID, namaSprint, tglMulai, tglAkhir);
  Future updateStatusSprint(id, status) =>
      sprintsApiProvider.updateStatusSprint(id, status);
}
