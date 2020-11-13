import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/ardith.jpg'),
              ),
              Text('Ardith Lutfiawan',
                  style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Text('Kakaknya Naruto',
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
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.confirmation_number, color: Colors.black54,
                  ),
                  title: Text('0110217068', style: TextStyle(color: Colors.black54, fontSize: 18),),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.email, color: Colors.black54,
                  ),
                  title: Text('ardith.lutfiawan@gmail.com', style: TextStyle(color: Colors.black54, fontSize: 18),),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.phone, color: Colors.black54,
                  ),
                  title: Text('081317907503', style: TextStyle(color: Colors.black54, fontSize: 18),),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.legend_toggle, color: Colors.black54,
                  ),
                  title: Text('Team 7', style: TextStyle(color: Colors.black54, fontSize: 18),),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.person, color: Colors.black54,
                  ),
                  title: Text('Mahasiswa', style: TextStyle(color: Colors.black54, fontSize: 18),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
