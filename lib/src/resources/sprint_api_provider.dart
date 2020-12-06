import 'dart:async';
import 'dart:convert';
import '../models/sprint_model.dart';
import 'package:http/http.dart' show Client;

import 'auth/shared_preferences_manager.dart';
import 'injector/injector.dart';

class SprintApiProvider {
  Client client = Client();
  final SharedPreferencesManager _sharedPreferencesManager =
  locator<SharedPreferencesManager>();

  final String baseurl = 'https://linkmatchsttnfapi.herokuapp.com';

  Future<String> getToken() async {
    final accessToken = _sharedPreferencesManager
        .getString(SharedPreferencesManager.keyAccessToken);
    return accessToken;
  }

  Future<ItemModelSprint> fetchSprintList() async {
    String token = await getToken();

    final response = await client.get("$baseurl/api/sprint", headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return ItemModelSprint.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Sprint');
    }
  }

  Future createNewSprint(sprint_id, nama_sprint, status) async {
    Map data = {
      'project_id': sprint_id.toString(),
      'nama': nama_sprint,
      'status': status,
    };
    var body = json.encode(data);

    print("inserted");
    final response = await client.post('$baseurl/api/sprint',
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body);

    if (response.statusCode == 200) {
      return ItemModelSprint.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to insert post');
    }
  }

  Future updateSprint(id, sprint_id, nama_sprint, kesulitan_id, status) async {
    Map data = {
      'sprint_id': sprint_id.toString(),
      'nama_sprint': nama_sprint,
      'kesulitan_id': kesulitan_id.toString(),
      'status': status,
    };
    var body = json.encode(data);

    print("updated");
    final response = await client.put("$baseurl/api/sprint/$id",
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body);

    if (response.statusCode == 200) {
      return ItemModelSprint.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to insert post');
    }
  }

  Future deleteSprint(id) async {
    String token = await getToken();

    final response = await client.delete("$baseurl/api/sprint/$id", headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      print("deleted");
      return false;
    }
  }
}
