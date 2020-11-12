import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/login_bloc.dart';
import 'package:lima_enam/src/ui/widget/register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc bloc = LoginBloc();

  void initState() {
    super.initState();
    // bloc.login('ardith', 'password');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
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
                    'Login',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(116.0, 40.5, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 70.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/tiktok.png', height: 182.0),
                emailField(bloc),
                passwordField(bloc),
                forgotPassword(),
                loadingIndicator(bloc),
                Container(margin: EdgeInsets.only(top: 65.0)),
                submitButton(bloc),
                SizedBox(height: 13.0),
                loginWithFB(),
                SizedBox(height: 85.0),
                registerNow()
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
                    color: Colors.black54),
                errorText: snap.error,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue))),
          );
        },
      );

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
                  color: Colors.black54),
              errorText: snap.error,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue))),
        );
      });

  Widget forgotPassword() {
    SizedBox(height: 5.0);
    return Container(
      alignment: Alignment(1.0, 0),
      padding: EdgeInsets.only(top: 15.0, left: 20.0),
      child: InkWell(
        onTap: () {},
        child: Text(
          'Lupa password',
          style: TextStyle(
              color: Colors.blue,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  Widget loginWithFB() {
    SizedBox(height: 20.0);
    return Container(
      height: 40.0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Center(
            //   child: ImageIcon(AssetImage('assets/images/facebook-logo.png')),
            // ),
            Center(
              child: Text(
                'Masuk dengan facebook',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget registerNow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Belum punya akun?',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        SizedBox(width: 5.0),
        InkWell(
          onTap: () {
            openRegisterScreen();
          },
          child: Text(
            'Daftar sekarang',
            style: TextStyle(
                color: Colors.blue,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }

  openRegisterScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return RegistenScreen();
      }),
    );
  }
}

//Widget submitButton(LoginBloc bloc) => StreamBuilder<bool>(
//  stream: bloc.submitValid,
//  builder: (context, snap) {
//    return RaisedButton(
//      onPressed: (!snap.hasData) ? null : bloc.submit,
//      child: Text('Login', style: TextStyle(color: Colors.white),),
//    color: Colors.blue,
//    );
//  },
//);

Widget submitButton(LoginBloc bloc) => StreamBuilder<bool>(
      stream: bloc.submitValid,
      builder: (context, snap) {
        return Container(
          height: 40.0,
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: Colors.blueAccent,
            color: Colors.blue,
            elevation: 7.0,
            child: GestureDetector(
              onTap: (!snap.hasData) ? null : bloc.submit,
              child: Center(
                child: Text(
                  'MASUK',
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
