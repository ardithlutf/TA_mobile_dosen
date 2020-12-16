import 'dart:async';
import 'dart:convert';
import '../models/task_model.dart';
import 'package:http/http.dart' show Client;

class TaskApiProvider {
  Client client = Client();

  final String baseurl = 'http://limastt.herokuapp.com';

  Future<ItemModelTask> fetchTaskList() async {
    final response = await client.get("$baseurl/api/tasks");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModelTask.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future createNewTask(sprintID, namaTask, kesulitanID, status) async {
    Map data = {
      'sprint_id': sprintID.toString(),
      'nama_task': namaTask,
      'kesulitan_id': kesulitanID.toString(),
      'status': status,
    };
    var body = json.encode(data);

    print("inserted");
    final response = await client.post('$baseurl/api/tasks',
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body);

    if (response.statusCode == 200) {
      return ItemModelTask.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to insert post');
    }
  }

  Future updateTask(id, sprintID, namaTask, kesulitanID, status) async {
    Map data = {
      'sprint_id': sprintID.toString(),
      'nama_task': namaTask,
      'kesulitan_id': kesulitanID.toString(),
      'status': status,
    };
    var body = json.encode(data);

    print("updated");
    final response = await client.put("$baseurl/api/tasks/$id",
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body);

    if (response.statusCode == 200) {
      return ItemModelTask.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to insert post');
    }
  }

  Future deleteTask(id) async {
    final response = await client.delete("$baseurl/api/tasks/$id");

    if (response.statusCode == 200) {
      return true;
    } else {
      print("deleted");
      return false;
    }
  }
}
