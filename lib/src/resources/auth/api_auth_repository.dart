import 'package:lima_enam/src/models/auth/login_body.dart';
import 'package:lima_enam/src/models/auth/token.dart';
import 'package:lima_enam/src/models/user_model.dart';

import 'api_auth_provider.dart';

class ApiAuthRepository {
  final ApiAuthProvider _apiAuthProvider = ApiAuthProvider();

  Future<Token> postLoginUser(LoginBody loginBody) => _apiAuthProvider.loginUser(loginBody);

  Future<ItemModelUser> fetchAllUsers() => _apiAuthProvider.getAllUsers();
}