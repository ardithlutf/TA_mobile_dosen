import 'dart:async';
import 'dart:convert';
import '../models/sprint_model.dart';
import 'package:http/http.dart' show Client, Request;

class SprintApiProvider {
  Client client = Client();

  final String baseurl = 'https://limastt.herokuapp.com';

  Future<ItemModelSprint> fetchSprintList() async {
    final response = await client.get("$baseurl/api/sprints");
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

  Future ambilSprintID() async {

    final response = await client.get("$baseurl/api/sprints");

    var listData = ItemModelSprint.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      return listData;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
