import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/home_bloc.dart';
import 'package:lima_enam/src/blocs/user_bloc.dart';
import 'package:lima_enam/src/models/user_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    blocUser.fetchUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      backgroundColor: Colors.blue[100],
      body: StreamBuilder(
          stream: blocUser.onlyUser,
          builder: (context, AsyncSnapshot<ItemModelUserProfile> snapshot) {
            if (snapshot.hasData) {
              return buildProfile(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget buildProfile(AsyncSnapshot<ItemModelUserProfile> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.results.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 20)),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage('${snapshot.data.results[index].foto}'),
                    ),
                    Text('${snapshot.data.results[index].nama}',
                        style: TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text('${snapshot.data.results[index].role}',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue[400],
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 20,
                      width: 200,
                      child: Divider(
                        color: Colors.black26,
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(
                          Icons.confirmation_number,
                          color: Colors.black54,
                        ),
                        title: Text(
                          '${snapshot.data.results[index].username}',
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Colors.black54,
                        ),
                        title: Text(
                          '${snapshot.data.results[index].email}',
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Colors.black54,
                        ),
                        title: Text(
                          '${snapshot.data.results[index].noHp}',
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                        ),
                      ),
                    ),
                    // Card(
                    //   margin: EdgeInsets.symmetric(
                    //       vertical: 10.0, horizontal: 25.0),
                    //   color: Colors.white,
                    //   child: ListTile(
                    //     leading: Icon(
                    //       Icons.legend_toggle,
                    //       color: Colors.black54,
                    //     ),
                    //     title: Text(
                    //       'Team 7',
                    //       style: TextStyle(color: Colors.black54, fontSize: 18),
                    //     ),
                    //   ),
                    // ),
                    // Padding(padding: EdgeInsets.only(top: 50)),
                    // Card(
                    //   margin: EdgeInsets.symmetric(
                    //       vertical: 10.0, horizontal: 25.0),
                    //   // color: Colors.white,
                    //   child: SizedBox(
                    //     width: 440.0,
                    //     height: 40,
                    //     child: new RaisedButton(
                    //       color: Colors.red,
                    //       child: new Text(
                    //         'Logout',
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //       onPressed: () {
                    //         locator<SharedPreferencesManager>().clearAll();
                    //         Navigator.pushAndRemoveUntil(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (BuildContext context) =>
                    //                   LoginScreen()),
                    //           (Route<dynamic> route) => false,
                    //         );
                    //         Timer(
                    //             Duration(seconds: 0), () => bloc.logoutUser());
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
