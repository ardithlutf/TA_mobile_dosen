import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable()
class LoginBody {
  String username;
  String password;

  LoginBody(this.username, this.password);

  factory LoginBody.fromJson(Map<String, dynamic> json) => _$LoginBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);

  @override
  String toString() {
    return 'LoginBody{username: $username, password: $password}';
  }
}