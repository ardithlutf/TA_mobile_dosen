import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lima_enam/src/blocs/auth/login_bloc2.dart';
import 'package:lima_enam/src/models/auth/login_body.dart';
import '../loading.dart';

class LoginScreen extends StatelessWidget {
  final LoginBloc _loginBloc = LoginBloc();
  final TextEditingController _controllerEmailAddress = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double heightScreen = mediaQueryData.size.height;
    double paddingBottom = mediaQueryData.padding.bottom;

    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => _loginBloc,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              String title = 'Info';
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(title),
                    content: Text('Username atau Password tidak sesuai'),
                  );
                },
              );
            } else if (state is LoginSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/dashboard_user_screen', (r) => false);
            }
          },
          child: Container(
            color: Colors.blue[100],
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                _buildWidgetTitleLogin(context),
                _buildWidgetImageHeader(heightScreen),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: paddingBottom == 0 ? 16.0 : paddingBottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            _buildWidgetSizedBox(heightScreen / 2.6),
                            _buildWidgetSizedBox(16.0),
                            _buildWidgetLabel(context, 'USERNAME'),
                            _buildWidgetTextFieldEmailAddress(),
                            _buildWidgetSizedBox(16.0),
                            _buildWidgetLabel(context, 'PASSWORD'),
                            _buildWidgetTextFieldPassword(),
                            _buildWidgetSizedBox(46.0),
                            _buildWidgetButtonSignin(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return WidgetCardLoading();
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetButtonSignin(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Text(
          'Masuk',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          String username = _controllerEmailAddress.text.trim();
          String password = _controllerPassword.text.trim();
          _loginBloc.add(LoginEvent(LoginBody(username, password)));
        },
        color: Colors.blue,
      ),
    );
  }

  Widget _buildWidgetTextFieldPassword() {
    return TextField(
      controller: _controllerPassword,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.black54),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  Widget _buildWidgetTextFieldEmailAddress() {
    return TextField(
      controller: _controllerEmailAddress,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.black54),
          // errorText: snap.error,
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  Widget _buildWidgetTitleLogin(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(12.0, 35.0, 0.0, 0.0),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 70.0, 0.0, 0.0),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
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
      ],
    );
  }

  Widget _buildWidgetLabel(BuildContext context, String label) {
    return Text(
      label,
      style: Theme.of(context).textTheme.subtitle1.merge(
            TextStyle(
              color: Colors.black54,
            ),
          ),
    );
  }

  Widget _buildWidgetSizedBox(double height) => SizedBox(height: height);

  Widget _buildWidgetImageHeader(double heightScreen) {
    return Container(
      height: 182.0,
      margin: EdgeInsets.only(top: 80),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/lm.png'),
        fit: BoxFit.fitHeight,
      )),
    );
  }
}
