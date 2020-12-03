import 'package:flutter/material.dart';
import 'package:lima_enam/src/resources/injector/injector.dart';
import 'package:lima_enam/src/ui/widget/login2.dart';
import 'package:lima_enam/src/ui/widget/splash/splash_page.dart';
import 'resources/auth/shared_preferences_manager.dart';

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     authBloc.restoreSession();
//     return MaterialApp(
//       title: "LIMA STT",
//       home: Scaffold(
//         body: createContent(),
//       ),
//     );
//   }
//
//   createContent() {
//     return StreamBuilder<bool> (
//         stream: authBloc.isSessionValid,
//         builder: (context, AsyncSnapshot<bool> snapshot){
//           if (snapshot.hasData && snapshot.data) {
//             return SplashPage();
//           }
//           return LoginScreen();
//         });
//   }
// }

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
        primaryColor: Color(0xFFF06038),
      ),
      home: _isAlreadyLoggedIn ? SplashPage() : LoginScreen(),
      routes: {
        '/login_screen': (context) => LoginScreen(),
        '/dashboard_user_screen': (context) => SplashPage(),
      },
    );
  }
}
