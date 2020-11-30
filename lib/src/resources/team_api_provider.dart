import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:lima_enam/src/models/team_model.dart';

class TeamApiProvider {
  Client client = Client();

  final String baseurl = 'https://linkmatchsttnfapi.herokuapp.com';
  String token = 'f7d427142e68101c8af6df1b624626f26f0c28fb';

  Future<ItemModelTeam> fetchTeamList() async {
    final response = await client.get("$baseurl/api/team?remember_token=$token");
    if (response.statusCode == 200) {
      return ItemModelTeam.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Team');
    }
  }
}