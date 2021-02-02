import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/sprints_bloc.dart';

class SprintDetail extends StatefulWidget {
  final int id;
  final String nama;
  final String tanggalMulai;
  final String tanggalAkhir;
  final String status;

  SprintDetail(
      {this.id, this.nama, this.tanggalMulai, this.tanggalAkhir, this.status});

  @override
  State<StatefulWidget> createState() {
    return SprintDetailState(
        id: id,
        nama: nama,
        tanggalMulai: tanggalMulai,
        tanggalAkhir: tanggalAkhir,
        status: status);
  }
}

class SprintDetailState extends State<SprintDetail> {
  void initState() {
    blocSprint.fetchAllSprints();
    super.initState();
  }

  @override
  void dispose() {
    // blocSprint.dispose();
    super.dispose();
  }

  final int id;
  final String nama;
  final String tanggalMulai;
  final String tanggalAkhir;
  final String status;

  SprintDetailState(
      {this.id, this.nama, this.tanggalMulai, this.tanggalAkhir, this.status});

  @override
  Widget build(BuildContext context) {
    blocSprint.fetchAllSprints();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
//                flexibleSpace: FlexibleSpaceBar(
//                    background: Image.network(
//                  "https://image.tmdb.org/t/p/w500/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg",
//                  fit: BoxFit.cover,
//                )),
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                  ),
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
                                  'Tanggal Mulai',
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
                                  'Tanggal Akhir',
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
                                title: Text('$tanggalMulai'.toString()),
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
                                title: Text('$tanggalAkhir'.toString()),
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
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.chat,
                        color: Colors.green,
                      ),
                      Container(
                        child: Text(
                          'Status',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  StreamBuilder(
                    builder: (context, snapshot) {
                      var statusSprint = ["Belum", "Proses", "Selesai"];

                      if (status == statusSprint[0]) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              width: double.maxFinite,
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: ListTile(
                                  title: Text(status),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              width: double.maxFinite,
                              child: RaisedButton(
                                child: Text(
                                  'Mulai Sprint',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  blocSprint.insertStatus(statusSprint[1]);
                                  blocSprint.updateStatusSprint(id);
                                },
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        );
                      } else if (status == statusSprint[1]) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              width: double.maxFinite,
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: ListTile(
                                  title: Text(status),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              width: double.maxFinite,
                              child: RaisedButton(
                                child: Text(
                                  'Akhiri Sprint',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  blocSprint.insertStatus(statusSprint[2]);
                                  blocSprint.updateStatusSprint(id);
                                },
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        );
                      }
                      return Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        width: double.maxFinite,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: ListTile(
                            title: Text(status),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  openSprintPage() {
    var count = 0;

    blocSprint.fetchAllSprints();
    Navigator.popUntil(context, (route) {
      return count++ == 1;
    });
  }
}
