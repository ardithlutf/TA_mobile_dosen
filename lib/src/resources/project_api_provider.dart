import 'dart:async';
import 'dart:convert';
import '../models/project_model.dart';
import 'package:http/http.dart' show Client;

import 'auth/shared_preferences_manager.dart';
import 'injector/injector.dart';

class ProjectApiProvider {
  Client client = Client();
  final SharedPreferencesManager _sharedPreferencesManager =
      locator<SharedPreferencesManager>();

  final String baseurl = 'https://linkmatchsttnfapi.herokuapp.com';

  Future<String> getToken() async {
    final accessToken = _sharedPreferencesManager
        .getString(SharedPreferencesManager.keyAccessToken);
    return accessToken;
  }

  Future<ItemModelProject> fetchSprintList() async {
    String token = await getToken();

    final response = await client.get("$baseurl/api/project", headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return ItemModelProject.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Project');
    }
  }
}
