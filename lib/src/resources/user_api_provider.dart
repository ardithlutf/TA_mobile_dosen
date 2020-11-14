import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Request;
import 'package:lima_enam/src/models/user_model.dart';

class UserApiProvider {
  Client client = Client();

  final String baseurl = 'https://linkmatchsttnf.herokuapp.com';

  Future<ItemModelUser> fetchUserList() async {
    final response = await client.get("$baseurl/user");
    if (response.statusCode == 200) {
      return ItemModelUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}