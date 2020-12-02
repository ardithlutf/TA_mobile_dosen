import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'token_type')
  String tokenType;
  @JsonKey(name: 'expires_in')
  int expiresIn;
  String error;

  Token(this.accessToken, this.tokenType, this.expiresIn);

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Token.withError(this.error);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @override
  String toString() {
    return 'Token{accessToken: $accessToken, tokenType: $tokenType, expiresIn: $expiresIn}';
  }
}
