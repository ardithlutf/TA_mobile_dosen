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

    final response = await client.get("$baseurl/api/project", headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return ItemModelSprint.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Project');
    }
  }

  Future createNewSprint(
      nama_sprint, desc_sprint, tgl_mulai, tgl_selesai) async {
    print("inserted");
    final response = await client.post("$baseurl/api/sprints", body: {
      'nama_sprint': nama_sprint,
      'desc_sprint': desc_sprint,
      'tgl_mulai': tgl_mulai,
      'tgl_selesai': tgl_selesai
    });

    if (response.statusCode == 200) {
      return ItemModelSprint.fromJson(json.decode(response.body));
//        return response.body;
    } else {
      throw Exception('Failed to insert post');
    }
  }
}
