import 'package:flutter/material.dart';

class AuthProvider {
  Future<String> login({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return 'access_token';
  }
}
