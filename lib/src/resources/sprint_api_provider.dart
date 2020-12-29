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

  Future createNewSprint(projectID, namaSprint, tglMulai, tglAkhir) async {
    String token = await getToken();

    Map data = {
      'nama': namaSprint,
      'project_id': projectID,
      'tanggal_mulai': tglMulai,
      'tanggal_akhir': tglAkhir,
      // 'status': status,
    };

    var body = json.encode(data);

    final response = await client.post("$baseurl/api/sprint",
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body);

    print("inserted");

    if (response.statusCode == 200) {
      return ItemModelSprint.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal menambahkan sprint');
    }
  }

  Future updateSprint(id, projectID, namaSprint, tglMulai, tglAkhir) async {
    String token = await getToken();

    Map data = {
      'nama': namaSprint,
      'project_id': projectID,
      'tanggal_mulai': tglMulai,
      'tanggal_akhir': tglAkhir,
      // 'status': status,
    };
    var body = json.encode(data);

    final response = await client.put("$baseurl/api/sprint/$id",
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body);

    print("updated");

    if (response.statusCode == 200) {
      return ItemModelSprint.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mengupdate sprint');
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
