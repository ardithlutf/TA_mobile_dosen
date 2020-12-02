import 'package:lima_enam/src/blocs/auth/login_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:lima_enam/src/ui/widget/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LoginBloc bloc = LoginBloc();
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => LoginScreen())));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 120),
            Image.asset('assets/images/undraw_new_decade_n4qd.png'),
            Center(
              child: Text(
                'Link and Match',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 32,
                    fontWeight: FontWeight.w100,
                    fontFamily: 'Montserrat'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
