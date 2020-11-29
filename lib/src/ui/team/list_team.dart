import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/teams_bloc.dart';
import 'package:lima_enam/src/models/team_model.dart';

import 'detail_team.dart';

class TeamList extends StatefulWidget {
  @override
  _TeamListState createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  void initState() {
    blocTeam.fetchAllTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team'),
      ),
      body: StreamBuilder(
        stream: blocTeam.allTeams,
        builder: (context, AsyncSnapshot<ItemModelTeam> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModelTeam> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.results.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: Card(
            clipBehavior: null,
            semanticContainer: true,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                    '${snapshot.data.results[index].nama.toString()}',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('LIHAT DETAIL'),
                      onPressed: () {
                        openDetailPage(snapshot.data, index);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ));
        });
  }

  openDetailPage(ItemModelTeam data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return TeamDetail(
          id: data.results[index].id,
          nama: data.results[index].nama,
          semester: data.results[index].semester,
          prodi: data.results[index].prodi,
          nilai: data.results[index].nilai,
          scrumMasterId: data.results[index].scrumMasterId,
          projectId: data.results[index].projectId,
        );
      }),
    );
  }
}
