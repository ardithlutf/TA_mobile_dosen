import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:lima_enam/src/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserApiProvider {
  Client client = Client();

  final String baseurl = 'https://linkmatchsttnfapi.herokuapp.com';

  Future<ItemModelUser> fetchUserList() async {
    final response =
        await client.get("$baseurl/api/user", );

    if (response.statusCode == 200) {
      return ItemModelUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<String> loginUser(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'username': username, 'password': password};
    var jsonResponse = null;

    final response = await client
        .post("$baseurl/api/login", body: data);

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
}
