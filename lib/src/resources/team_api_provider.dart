import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Request;
import 'package:lima_enam/src/models/team_model.dart';

class TeamApiProvider {
  Client client = Client();

  final String baseurl = 'https://linkmatchsttnf.herokuapp.com';

  Future<ItemModelTeam> fetchTeamList() async {
    final response = await client.get("$baseurl/api/team");
    if (response.statusCode == 200) {
      return ItemModelTeam.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Team');
    }
  }
}