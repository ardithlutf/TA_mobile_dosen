import 'package:flutter/material.dart';
import 'package:lima_enam/src/ui/home.dart';
import 'package:lima_enam/src/ui/widget/komponen/splashScreen.dart';
import 'package:lima_enam/src/ui/widget/komponen/splash_page.dart';
import 'package:lima_enam/src/ui/widget/login.dart';
import 'file:///C:/Users/ardit/Documents/backup/10Okt-Windows/AndroidStudioProjects/flutter/lima_enam/lib/src/ui/widget/komponen/splashScreen.dart';

import 'blocs/authorization_bloc.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authBloc.restoreSession();
    return MaterialApp(
      title: "LIMA STT",
      home: Scaffold(
        body: createContent(),
      ),
    );
  }

  createContent() {
    return StreamBuilder<bool> (
        stream: authBloc.isSessionValid,
        builder: (context, AsyncSnapshot<bool> snapshot){
          if (snapshot.hasData && snapshot.data) {
            return SplashPage();
          }
          return LoginScreen();
        });
  }
}
