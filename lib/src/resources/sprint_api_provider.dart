import 'dart:async';
import 'dart:convert';
import '../models/sprint_model.dart';
import 'package:http/http.dart' show Client;

class SprintApiProvider {
  Client client = Client();

  // final String baseurl = 'https://limastt.herokuapp.com';
  final String baseurl = 'https://linkmatchsttnfapi.herokuapp.com';
  String token = 'f7d427142e68101c8af6df1b624626f26f0c28fb';

  Future<ItemModelSprint> fetchSprintList() async {
    final response = await client.get("$baseurl/api/project?remember_token=$token");
    if (response.statusCode == 200) {
      return ItemModelSprint.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
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

  Future deleteSprint(id) async {
    final response = await client.delete("$baseurl/api/sprints/$id");

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception();
    }
  }
}
