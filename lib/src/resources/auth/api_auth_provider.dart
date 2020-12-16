import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lima_enam/src/models/auth/login_body.dart';
import 'package:lima_enam/src/models/auth/token.dart';
import 'package:lima_enam/src/models/user_model.dart';
import 'package:lima_enam/src/resources/utils/dio_logging_interceptors.dart';

class ApiAuthProvider {
  final Dio _dio = new Dio();
  final String _baseUrl = 'https://linkmatchsttnfapi.herokuapp.com/';

  ApiAuthProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<Token> loginUser(LoginBody loginBody) async {
    try {
      final response = await _dio.post(
        'api/login',
        data: FormData.fromMap(loginBody.toJson()),
      );
      return Token.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return Token.withError('$error');
    }
  }

  Future<ItemModelUser> getAllUsers() async {
    try {
      print('getAllUsers');
      final response = await _dio.get(
        'api/user',
        options: Options(
          headers: {
            'requirestoken': true,
          },
        ),
      );
      return ItemModelUser.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return null;
    }
  }

  void _printError(error, StackTrace stacktrace) {
    debugPrint('error: $error & stacktrace: $stacktrace');
  }
}
