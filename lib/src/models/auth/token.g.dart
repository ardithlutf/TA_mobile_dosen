// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    json['access_token'] as String,
    json['token_type'] as String,
    json['expires_in'] as int,
  )..error = json['error'] as String;
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'error': instance.error,
    };
