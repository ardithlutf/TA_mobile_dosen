import 'package:flutter/material.dart';
import 'package:lima_enam/src/ui/widget/komponen/splash_page.dart';
import 'package:lima_enam/src/ui/widget/login.dart';

import 'blocs/auth/authorization_bloc.dart';


class App extends StatelessWidget {
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