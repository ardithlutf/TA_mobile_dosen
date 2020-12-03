import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lima_enam/src/blocs/splash_bloc/splash_bloc.dart';
import '../../home.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashBloc _splashBloc = SplashBloc();

  void initState() {
    _splashBloc.add(SetSplash());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: BlocProvider(
          create: (_) => _splashBloc,
          child: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state is SplashLoaded) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => MyApp()));
              }
            },
            child: _buildSplashWidget(),
          ),
        ),
      ),
    );
  }

  Widget _buildSplashWidget() {
    return Center(
      child: Text(
        "Link and Match",
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );
  }
}
