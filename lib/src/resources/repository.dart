import 'dart:async';

// provider
import 'package:lima_enam/src/models/team_model.dart';
import 'package:lima_enam/src/resources/team_api_provider.dart';

import 'auth/auth_provider.dart';
import 'sprint_api_provider.dart';
import 'task_api_provider.dart';
import 'user_api_provider.dart';

// model
import '../models/sprint_model.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';

class Repository {
  //AUTH
  final AuthProvider authProvider = AuthProvider();

  final SprintsApiProvider = SprintApiProvider();
  final TasksApiProvider = TaskApiProvider();
  final UsersApiProvider = UserApiProvider();
  final TeamsApiProvider = TeamApiProvider();

  Future<String> login(String email, String password) =>
      authProvider.login(email: email, password: password);
  Future<ItemModelUser> loginUsers(String username, String password) => UsersApiProvider.loginUser(username, password);

  Future<ItemModelSprint> fetchAllSprints() =>
      SprintsApiProvider.fetchSprintList();
  Future<ItemModelTask> fetchAllTasks() => TasksApiProvider.fetchTaskList();
  Future<ItemModelUser> fetchAllUsers() => UsersApiProvider.fetchUserList();
  Future<ItemModelTeam> fetchAllTeams() => TeamsApiProvider.fetchTeamList();

  // CRUD Project
  Future createNewSprint(nama_sprint, desc_sprint, tgl_mulai, tgl_selesai) =>
      SprintsApiProvider.createNewSprint(
          nama_sprint, desc_sprint, tgl_mulai, tgl_selesai);
  Future deleteOldSprint(id) => SprintsApiProvider.deleteSprint(id);

  // CRUD Sprint
  Future createNewTask(sprint_id, nama_task, kesulitan_id, status) =>
      TasksApiProvider.createNewTask(
          sprint_id, nama_task, kesulitan_id, status);
  Future updateTask(id, sprint_id, nama_task, kesulitan_id, status) =>
      TasksApiProvider.updateTask(
          id, sprint_id, nama_task, kesulitan_id, status);
  Future deleteOldTask(id) => TasksApiProvider.deleteTask(id);
}
