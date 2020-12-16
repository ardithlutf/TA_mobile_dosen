import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String field;
  final IconData icon;

  ProfileCard({@required this.field, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      color: Colors.white,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black54,
        ),
        title: Text(
          field,
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
      ),
    );
  }
}
