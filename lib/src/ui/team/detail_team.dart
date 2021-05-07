import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/teams_bloc.dart';

class TeamDetail extends StatefulWidget {
  final int id;
  final String nama;
  final String semester;
  final String prodi;
  final String nilai;
  final dynamic scrumMasterId;

  TeamDetail({
    this.id,
    this.nama,
    this.semester,
    this.prodi,
    this.nilai,
    this.scrumMasterId,
  });

  @override
  State<StatefulWidget> createState() {
    return TeamDetailState(
      id: id,
      nama: nama,
      semester: semester,
      prodi: prodi,
      nilai: nilai,
      scrumMasterId: scrumMasterId,
    );
  }
}

class TeamDetailState extends State<TeamDetail> {
  void initState() {
    blocTeam.fetchAllTeams();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final int id;
  final String nama;
  final String semester;
  final String prodi;
  final String nilai;
  final dynamic scrumMasterId;

  TeamDetailState({
    this.id,
    this.nama,
    this.semester,
    this.prodi,
    this.nilai,
    this.scrumMasterId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Center(
                  child: Text(
                    "$nama",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                  Table(
                    border: TableBorder.all(
                        color: Colors.black26,
                        width: 1,
                        style: BorderStyle.none),
                    children: [
                      TableRow(children: [
                        TableCell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: Colors.green,
                              ),
                              Container(
                                child: Text(
                                  'Semester',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TableCell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: Colors.green,
                              ),
                              Container(
                                child: Text(
                                  'Prodi',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Container(
                            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            width: double.maxFinite,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: ListTile(
                                title: Text('$semester'.toString()),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            width: double.maxFinite,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: ListTile(
                                title: Text('$prodi'.toString()),
                              ),
                            ),
                          ),
                        )
                      ])
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                  ),
                  Table(
                    children: [
                      TableRow(children: [
                        TableCell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.monetization_on_sharp,
                                color: Colors.green,
                              ),
                              Container(
                                child: Text(
                                  'Nilai',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TableCell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time_rounded,
                                color: Colors.green,
                              ),
                              Container(
                                child: Text(
                                  'Scrum Master',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Container(
                            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            width: double.maxFinite,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: ListTile(
                                title: Text('$nilai'),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            width: double.maxFinite,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: ListTile(
                                title: Text(scrumMasterId.toString()),
                              ),
                            ),
                          ),
                        )
                      ])
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
