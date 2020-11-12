import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/home_bloc.dart';
import 'package:lima_enam/src/blocs/sprints_bloc.dart';
import 'package:lima_enam/src/blocs/tasks_bloc.dart';
import 'package:lima_enam/src/models/sprint_model.dart';
import 'package:lima_enam/src/models/task_model.dart';
import 'package:lima_enam/src/resources/adapter/json_mahasiswa_adapter.dart';
import 'package:lima_enam/src/resources/adapter/mahasiswa_adapter.dart';
import 'package:lima_enam/src/ui/mahasiswa/list_mahasiswa.dart';
import 'package:lima_enam/src/ui/mahasiswa/mahasiswa_section.dart';
import 'package:lima_enam/src/ui/sprint/list_sprint.dart';
import 'package:lima_enam/src/ui/task/create_task3.dart';
import 'package:lima_enam/src/ui/task/list_task.dart';
import 'file:///C:/Users/ardit/Documents/backup/10Okt-Windows/AndroidStudioProjects/flutter/lima_enam/lib/src/ui/widget/komponen/splashScreen.dart';
import 'package:lima_enam/src/ui/widget/login.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HomeBloc bloc = HomeBloc();

  void initState() {
    blocSprint.fetchAllSprints();
    blocTask.fetchAllTasks();
    super.initState();
  }

  @override
  void dispose() {
//    blocSprint.dispose();
//    blocTask.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // blocSprint.fetchAllSprints();
    // blocTask.fetchAllTasks();
    return MaterialApp(
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(
              //TODO: Color Hexa = #0EB10E
              primarySwatch: Colors.blue,
              cardColor: Colors.white70,
              backgroundColor: Colors.white)),
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
    // blocSprint.fetchAllSprints();
    // blocTask.fetchAllTasks();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
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
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Ardith Lutfiawan"),
              accountEmail: Text("ardith.lutfiawan@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.android
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  "AL",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            // ListTile(
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) => SplashScreen()));
            //     Timer(Duration(seconds: 2), () => bloc.logoutUser());
            //   },
            //   title: Text("Profile"),
            // ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()));
                Timer(Duration(seconds: 2), () => bloc.logoutUser());
              },
              title: Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }

  // Widget homeSprint(AsyncSnapshot<ItemModelSprint> snapshot) {
  //   blocSprint.fetchAllSprints();
  //   return ListTile(
  //       onTap: () {
  //         Navigator.of(context).push(MaterialPageRoute(
  //             builder: (BuildContext context) => SprintList()));
  //       },
  //       title: Text("Sprint"),
  //       leading: Icon(Icons.library_books),
  //       trailing: Container(
  //         width: 20,
  //         height: 20,
  //         child: Center(
  //             child: Text(
  //           '${snapshot.data.results.length}',
  //           style: TextStyle(color: Colors.white),
  //         )),
  //         decoration: BoxDecoration(
  //             shape: BoxShape.circle, color: Colors.lightBlue[800]),
  //       ));
  // }

  Card DashboardItem(String title, IconData icon) {
    blocSprint.fetchAllSprints();
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {
              switch (title) {
                case "Project":
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SprintList()));
                  }
                  break;
                case "Sprint":
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => TaskList()));
                  }
                  break;
                case "Mahasiswa":
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MahasiswaList(
                            adapter: JsonMahasiswaAdapter(),
                            headerText: 'Oke')));
                  }
                  break;
                case "Profile":
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreensss()));
                  }
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
