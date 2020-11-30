import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:lima_enam/src/models/user_model.dart';

class UserApiProvider {
  Client client = Client();

  final String baseurl = 'https://linkmatchsttnfapi.herokuapp.com';
  String token = 'f7d427142e68101c8af6df1b624626f26f0c28fb';

  Future<ItemModelUser> fetchUserList() async {
    final response =
        await client.get("$baseurl/api/user?remember_token=$token");

    if (response.statusCode == 200) {
      return ItemModelUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<ItemModelUser> loginUser(String username, String password) async {
    final response = await client
        .post("$baseurl", body: {"username": username, "password": password});

    if (response.statusCode == 200) {
      return ItemModelUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }
}
