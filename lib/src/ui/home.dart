import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/home_bloc.dart';
import 'package:lima_enam/src/blocs/user_bloc.dart';
import 'package:lima_enam/src/models/user_model.dart';
import 'package:lima_enam/src/resources/auth/shared_preferences_manager.dart';
import 'package:lima_enam/src/resources/injector/injector.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/login/login2.dart';

class DashboardAdmin extends StatefulWidget {
  @override
  _DashboardAdminState createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
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
    return MaterialApp(
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue,
              cardColor: Colors.white,
              backgroundColor: Colors.blue[100])),
      home: MyHomePage(title: 'Semester Ganjil 2020/2021'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeBloc bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Warning'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Anda yakin ingin melakukan Logout?"),
                          ],
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Lanjut",
                                style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              locator<SharedPreferencesManager>().clearAll();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LoginScreen()),
                                (Route<dynamic> route) => false,
                              );
                              Timer(Duration(seconds: 0),
                                  () => bloc.logoutUser());
                            },
                          ),
                          FlatButton(
                            child: Text("Batal"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    });
              })
        ],
      ),
      body: StreamBuilder(
          stream: blocUser.onlyUser,
          builder: (context, AsyncSnapshot<ItemModelUserProfile> snapshot) {
            if (snapshot.hasData) {
              return buildMenu(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget buildMenu(AsyncSnapshot<ItemModelUserProfile> snapshot) {
    return PageView.builder(itemBuilder: (BuildContext context, int index) {
      switch (snapshot.data.results[index].role) {
        case "Dosen":
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(3.0),
              children: <Widget>[
                DashboardCard(title: 'Project', icon: Icons.library_books),
                DashboardCard(title: 'Sprint', icon: Icons.library_books),
                DashboardCard(title: 'Tim', icon: Icons.book),
                DashboardCard(title: 'Mahasiswa', icon: Icons.book),
                DashboardCard(
                    title: 'Profile', icon: Icons.account_circle_outlined),
              ],
            ),
          );
          break;
        case "Administrator":
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(3.0),
              children: <Widget>[
                DashboardCard(title: 'Project', icon: Icons.library_books),
                DashboardCard(title: 'Sprint', icon: Icons.library_books),
                DashboardCard(title: 'Tim', icon: Icons.book),
                DashboardCard(title: 'Mahasiswa', icon: Icons.book),
                DashboardCard(
                    title: 'Profile', icon: Icons.account_circle_outlined),
              ],
            ),
          );
          break;
        case "Scrum Master":
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(3.0),
              children: <Widget>[
                DashboardCard(title: 'Project', icon: Icons.library_books),
                DashboardCard(title: 'Sprint', icon: Icons.library_books),
                DashboardCard(title: 'Tim', icon: Icons.book),
                DashboardCard(title: 'Mahasiswa', icon: Icons.book),
                DashboardCard(
                    title: 'Profile', icon: Icons.account_circle_outlined),
              ],
            ),
          );
          break;
        case "Product Owner":
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(3.0),
              children: <Widget>[
                DashboardCard(title: 'Project', icon: Icons.library_books),
                DashboardCard(
                    title: 'Profile', icon: Icons.account_circle_outlined),
              ],
            ),
          );
          break;
      }
      if (snapshot.data.results[index].role == "Dosen") {
      } else {
        return Container();
      }
    });
  }
}
