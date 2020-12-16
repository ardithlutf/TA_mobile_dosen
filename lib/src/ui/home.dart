import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/home_bloc.dart';
import 'package:lima_enam/src/blocs/user_bloc.dart';
import 'package:lima_enam/src/models/user_model.dart';
import 'package:lima_enam/src/resources/auth/shared_preferences_manager.dart';
import 'package:lima_enam/src/resources/injector/injector.dart';
import 'package:lima_enam/src/ui/project/list_project.dart';
import 'package:lima_enam/src/ui/team/list_team.dart';
import 'package:lima_enam/src/ui/user/user_section.dart';
import 'package:lima_enam/src/ui/widgets/login2.dart';
import 'package:lima_enam/src/ui/widgets/profile/profile_page.dart';

import 'sprint/list_sprint.dart';

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
  _MyHomePageState createState() => new _MyHomePageState();
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
                DashboardItem("Project", Icons.library_books),
                DashboardItem("Sprint", Icons.library_books),
                DashboardItem("Tim", Icons.book),
                DashboardItem("Mahasiswa", Icons.book),
                DashboardItem("Profile", Icons.account_circle_outlined),
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
                DashboardItem("Project", Icons.library_books),
                DashboardItem("Sprint", Icons.library_books),
                DashboardItem("Tim", Icons.book),
                DashboardItem("Mahasiswa", Icons.book),
                DashboardItem("Profile", Icons.account_circle_outlined),
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
                DashboardItem("Project", Icons.library_books),
                DashboardItem("Sprint", Icons.library_books),
                DashboardItem("Tim", Icons.book),
                DashboardItem("Mahasiswa", Icons.book),
                DashboardItem("Profile", Icons.account_circle_outlined),
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
                DashboardItem("Project", Icons.library_books),
                DashboardItem("Profile", Icons.account_circle_outlined),
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

  Card DashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: new InkWell(
            onTap: () {
              switch (title) {
                case "Project":
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ProjectList()));
                  }
                  break;
                case "Sprint":
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SprintList()));
                  }
                  break;
                case "Mahasiswa":
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            UserSection(headerText: 'Mahasiswa')));
                  }
                  break;
                case "Profile":
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ProfilePage()));
                  }
                  break;
                case "Tim":
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => TeamList()));
                  }
                  break;
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}
