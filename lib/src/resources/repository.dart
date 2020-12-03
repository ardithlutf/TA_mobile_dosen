import 'dart:async';

// provider
import 'package:lima_enam/src/resources/team_api_provider.dart';
import 'auth/auth_provider.dart';
import 'project_api_provider.dart';
import 'task_api_provider.dart';
import 'user_api_provider.dart';

// model
import '../models/team_model.dart';
import '../models/project_model.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';

class Repository {
  //AUTH
  final AuthProvider authProvider = AuthProvider();

  final UsersApiProvider = UserApiProvider();
  final ProjectsApiProvider = ProjectApiProvider();
  final TasksApiProvider = TaskApiProvider();
  final TeamsApiProvider = TeamApiProvider();

  Future<String> login(String username, String password) =>
      authProvider.login(username: username, password: password);
  Future<String> loginUsers(String username, String password) =>
      UsersApiProvider.loginUser(username, password);

  Future<ItemModelProject> fetchAllSprints() =>
      ProjectsApiProvider.fetchSprintList();
  Future<ItemModelTask> fetchAllTasks() => TasksApiProvider.fetchTaskList();
  Future<ItemModelUser> fetchAllUsers() => UsersApiProvider.fetchUserList();
  Future<ItemModelUserProfile> fetchUserProfile() =>
      UsersApiProvider.fetchUserProfile();
  Future<ItemModelTeam> fetchAllTeams() => TeamsApiProvider.fetchTeamList();

  // CRUD Sprint
  Future createNewTask(sprint_id, nama_task, kesulitan_id, status) =>
      TasksApiProvider.createNewTask(
          sprint_id, nama_task, kesulitan_id, status);
  Future updateTask(id, sprint_id, nama_task, kesulitan_id, status) =>
      TasksApiProvider.updateTask(
          id, sprint_id, nama_task, kesulitan_id, status);
  Future deleteOldTask(id) => TasksApiProvider.deleteTask(id);
}
