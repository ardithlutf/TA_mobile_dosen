import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/login_bloc.dart';
import 'package:lima_enam/src/ui/widget/register.dart';

import 'login.dart';

class RegistenScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegistenScreen> {
  LoginBloc bloc = LoginBloc();

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(12.0, 35.0, 0.0, 0.0),
                  child: Text(
                    'LIMA STT NF',
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.w100, fontFamily: 'Montserrat'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 70.0, 0.0, 0.0),
                  child: Text(
                    'Register',
                    style:
                    TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(166.0, 40.5, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 70.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/undraw_grid_design_obmd.png', height: 182.0),
                emailField(bloc),
                nicknameField(bloc),
                passwordField(bloc),
                Container(margin: EdgeInsets.only(top: 45.0)),
                submitButton(bloc),
                SizedBox(height: 13.0),
                loginButton(bloc),
                SizedBox(height: 5.0),
                loadingIndicator(bloc),
//                SizedBox(height: 85.0),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget loadingIndicator(LoginBloc bloc) => StreamBuilder<bool>(
        stream: bloc.loading,
        builder: (context, snap) {
          return Container(
            child: (snap.hasData && snap.data)
                ? CircularProgressIndicator()
                : null,
          );
        },
      );

  Widget emailField(LoginBloc bloc) => StreamBuilder<String>(
        stream: bloc.email,
        builder: (context, snap) {
          SizedBox(height: 20.0);
          return TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: bloc.changeEmail,
            decoration: InputDecoration(
                labelText: 'EMAIL',
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                errorText: snap.error,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green))),
          );
        },
      );

  Widget nicknameField(LoginBloc bloc) => StreamBuilder<String>(
      builder: (context, snap) {
        SizedBox(height: 5.0);
        return TextField(
          decoration: InputDecoration(
              labelText: 'NICKNAME',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              errorText: snap.error,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green))),
        );
      });

  Widget passwordField(LoginBloc bloc) => StreamBuilder<String>(
      stream: bloc.password,
      builder: (context, snap) {
        SizedBox(height: 5.0);
        return TextField(
          obscureText: true,
          onChanged: bloc.changePassword,
          decoration: InputDecoration(
              labelText: 'PASSWORD',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              errorText: snap.error,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green))),
        );
      });

  Widget submitButton(LoginBloc bloc) => StreamBuilder<bool>(
        stream: bloc.submitValid,
        builder: (context, snap) {
          return Container(
            height: 40.0,
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: Colors.greenAccent,
              color: Colors.green,
              elevation: 7.0,
              child: GestureDetector(
                onTap: () {},
                child: Center(
                  child: Text(
                    'BUAT AKUN',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
            ),
          );
        },
      );

  Widget loginButton(LoginBloc bloc) => StreamBuilder<bool>(
        stream: bloc.submitValid,
        builder: (context, snap) {
          return Container(
            height: 40.0,
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: Colors.white70,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.0),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0)),
                child: InkWell(
                  onTap: () {
                    openLoginScreen();
                  },
                  child: Center(
                    child: Text(
                      'MASUK',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );

  openLoginScreen() {
    Navigator.pop(
      context,
      MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }),
    );
  }
}
