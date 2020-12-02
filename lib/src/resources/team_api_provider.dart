import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:lima_enam/src/models/team_model.dart';
import 'package:lima_enam/src/resources/auth/shared_preferences_manager.dart';
import 'injector/injector.dart';

class TeamApiProvider {
  Client client = Client();
  final SharedPreferencesManager _sharedPreferencesManager = locator<SharedPreferencesManager>();

  final String baseurl = 'https://linkmatchsttnfapi.herokuapp.com';

  Future<String> getToken() async {
    final accessToken = _sharedPreferencesManager
        .getString(SharedPreferencesManager.keyAccessToken);
    return accessToken;
  }

  Future<ItemModelTeam> fetchTeamList() async {
    String token = await getToken();

    final response = await client.get("$baseurl/api/team", headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return ItemModelTeam.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Team');
    }
  }
}