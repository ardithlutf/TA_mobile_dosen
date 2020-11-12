import 'dart:async';
import 'auth_provider.dart';
import 'sprint_api_provider.dart';
import 'task_api_provider.dart';
import '../models/sprint_model.dart';
import '../models/task_model.dart';

class Repository {
  //AUTH
  final AuthProvider authProvider = AuthProvider();

  final SprintsApiProvider = SprintApiProvider();
  final TasksApiProvider = TaskApiProvider();

  Future<String> login(String email, String password) => authProvider.login(email: email, password: password);

  Future<ItemModelSprint> fetchAllSprints() => SprintsApiProvider.fetchSprintList();
  Future<ItemModelTask> fetchAllTasks() => TasksApiProvider.fetchTaskList();

  Future createNewSprint(nama_sprint, desc_sprint, tgl_mulai, tgl_selesai) =>
      SprintsApiProvider.createNewSprint(nama_sprint, desc_sprint, tgl_mulai, tgl_selesai);
  Future createNewTask(sprint_id, nama_task, kesulitan_id, status) =>
      TasksApiProvider.createNewTask(sprint_id, nama_task, kesulitan_id, status);

  Future updateTask(id, sprint_id, nama_task, kesulitan_id, status) => TasksApiProvider.updateTask(id, sprint_id, nama_task, kesulitan_id, status);

  Future deleteOldSprint(id) => SprintsApiProvider.deleteSprint(id);
  Future deleteOldTask(id) => TasksApiProvider.deleteTask(id);

  Future ambilSprintID() => SprintsApiProvider.ambilSprintID();
}
