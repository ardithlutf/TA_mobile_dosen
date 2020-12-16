import 'package:flutter/material.dart';
import 'package:lima_enam/src/resources/injector/injector.dart';
import 'file:///C:/Users/ardit/Documents/backup/10Okt-Windows/AndroidStudioProjects/flutter/lima_enam/lib/src/ui/widgets/login/login2.dart';
import 'package:lima_enam/src/ui/widgets/splash/splash_page.dart';
import 'resources/auth/shared_preferences_manager.dart';

class App extends StatelessWidget {
  final SharedPreferencesManager _sharedPreferencesManager =
      locator<SharedPreferencesManager>();

  @override
  Widget build(BuildContext context) {
    bool _isAlreadyLoggedIn = _sharedPreferencesManager
            .isKeyExists(SharedPreferencesManager.keyIsLogin)
        ? _sharedPreferencesManager.getBool(SharedPreferencesManager.keyIsLogin)
        : false;

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: _isAlreadyLoggedIn ? SplashPage() : LoginScreen(),
    );
  }
}
