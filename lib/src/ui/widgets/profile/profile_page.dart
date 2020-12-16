import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/user_bloc.dart';
import 'package:lima_enam/src/models/user_model.dart';

import 'profile_card.dart';

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
  void dispose() {
    super.dispose();
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
          String nama = snapshot.data.results[index].nama;
          String role = snapshot.data.results[index].role;
          String username = snapshot.data.results[index].username;
          String email = snapshot.data.results[index].email;
          String noHp = snapshot.data.results[index].noHp;
          String foto = snapshot.data.results[index].foto;

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
                          NetworkImage('$foto'),
                    ),
                    Text('$nama',
                        style: TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text('$role',
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
                    ProfileCard(field: username, icon: Icons.confirmation_number),
                    ProfileCard(field: email, icon: Icons.email),
                    ProfileCard(field: noHp, icon: Icons.phone),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
