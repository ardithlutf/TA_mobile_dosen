import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:lima_enam/src/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/shared_preferences_manager.dart';
import 'injector/injector.dart';

class UserApiProvider {
  Client client = Client();
  final SharedPreferencesManager _sharedPreferencesManager =
      locator<SharedPreferencesManager>();

  final String baseurl = 'https://linkmatchsttnfapi.herokuapp.com';

  Future<String> getToken() async {
    final accessToken = _sharedPreferencesManager
        .getString(SharedPreferencesManager.keyAccessToken);
    return accessToken;
  }

  Future<String> loginUser(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'username': username, 'password': password};
    var jsonResponse;

    final response = await client.post("$baseurl/api/login", body: data);

    if (response.statusCode == 200) {
      // return ItemModelUser.fromJson(json.decode(response.body));
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        sharedPreferences.setString("token", jsonResponse['access_token']);
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<ItemModelUser> fetchUserList() async {
    String token = await getToken();

    final response = await client.get("$baseurl/api/user", headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return ItemModelUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Mahasiswa');
    }
  }

  Future<ItemModelUserProfile> fetchUserProfile() async {
    String token = await getToken();

    final response = await client.get("$baseurl/api/profile", headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return ItemModelUserProfile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Profile');
    }
  }
}
