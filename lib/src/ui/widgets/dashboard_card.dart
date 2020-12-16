import 'package:flutter/material.dart';
import 'package:lima_enam/src/ui/project/list_project.dart';
import 'package:lima_enam/src/ui/sprint/list_sprint.dart';
import 'package:lima_enam/src/ui/team/list_team.dart';
import 'package:lima_enam/src/ui/user/user_section.dart';

import 'profile/profile_page.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;

  DashboardCard({@required this.title, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: InkWell(
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
                        builder: (BuildContext context) => UserSection(
                              headerText: 'Mahasiswa',
                              adapter: null,
                            )));
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
                Center(
                  child: Text(title,
                      style: TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}
