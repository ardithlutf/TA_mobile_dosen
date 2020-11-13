import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/tasks_bloc.dart';
import 'package:lima_enam/src/models/task_model.dart';
import '../../blocs/sprints_bloc.dart';
import 'list_sprint.dart';

class SprintDetail extends StatefulWidget {
  final int id;
  final String nama_sprint;
  final String desc_sprint;
  final String tgl_mulai;
  final String tgl_selesai;

  SprintDetail({
    this.id,
    this.nama_sprint,
    this.desc_sprint,
    this.tgl_mulai,
    this.tgl_selesai
  });

  @override
  State<StatefulWidget> createState() {
    return SprintDetailState(
      id: id,
      nama_sprint: nama_sprint,
      desc_sprint: desc_sprint,
      tgl_mulai: tgl_mulai,
      tgl_selesai: tgl_selesai
    );
  }
}

class SprintDetailState extends State<SprintDetail> {
  void initState() {
    blocTask.fetchAllTasks();
    super.initState();
  }

  @override
  void dispose() {
//    blocTask.dispose();
    super.dispose();
  }

  final int id;
  final String nama_sprint;
  final String desc_sprint;
  final String tgl_mulai;
  final String tgl_selesai;


  SprintDetailState({
    this.id,
    this.nama_sprint,
    this.desc_sprint,
    this.tgl_mulai,
    this.tgl_selesai,
  });

  @override
  Widget build(BuildContext context) {
    blocTask.fetchAllTasks();
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
                    "$nama_sprint",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.delete),
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
                                    Text(
                                        "Anda ingin menghapus project:"),
                                    Text(
                                        "$nama_sprint", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Lanjut", style: TextStyle(color: Colors.red)),
                                    onPressed: () {
                                      blocSprint.deleteSprint("$id");
                                      setState(() {
                                        Navigator.pop(context);
                                        blocSprint.fetchAllSprints();
                                      });
                                      openSprintPage();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("Batal"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      }),
                ],
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
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.chat,
                        color: Colors.green,
                      ),
                      Container(
                        child: Text(
                          'Deskripsi',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    height: 150,
                    width: double.maxFinite,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: EdgeInsets.all(1),
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(desc_sprint))
                              ],
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
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
                                title: Text('$tgl_mulai'.toString()),
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
                                title: Text('$tgl_selesai'.toString()),
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
                        Icons.list,
                        color: Colors.green,
                      ),
                      Container(
                        child: Text(
                          'Sprint',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        margin: EdgeInsets.only(left: 1.0, right: 1.0),
                      ),
                    ],
                  ),
                  Container(
                      height: 141,
                      child: Scaffold(
                        body: StreamBuilder(
                          stream: blocTask.allTasks,
                          builder:
                              (context, AsyncSnapshot<ItemModelTask> snapshot) {
                            if (snapshot.hasData) {
                              return buildListTask(snapshot, id);
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
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
                                  'Budget',
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
                                  'Status',
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
                                title: Text('Rp.999999,-'),
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
                                title: Text('Selesai'),
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

  openSprintPage() {
    var count = 0;

    blocSprint.fetchAllSprints();
    Navigator.popUntil(context, (route) {
      return count++ == 1;
    });
  }
}

Widget _myListView(BuildContext context) {
  final titles = [
    'bike',
    'boat',
    'bus',
    'car',
    'railway',
  ];

  final icons = [
    Icons.directions_bike,
    Icons.directions_boat,
    Icons.directions_bus,
    Icons.directions_car,
    Icons.directions_railway,
  ];

  return ListView.builder(
    itemCount: titles.length,
    itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          leading: Icon(icons[index]),
          title: Text(titles[index]),
        ),
      );
    },
  );
}

Widget buildListTask(AsyncSnapshot<ItemModelTask> snapshot, id) {
  final icons = [
    Icons.directions_bike,
    Icons.directions_boat,
    Icons.directions_bus,
    Icons.directions_car,
    Icons.directions_railway,
  ];

  return ListView.builder(
      // primary: false,
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      itemCount: snapshot.data.results.length,
      itemBuilder: (context, index) {
        if (snapshot.data.results[index].sprint_id == id) {
          return Card(
            child: ListTile(
              leading: Icon(icons[index]),
              title:
                  Text('${snapshot.data.results[index].nama_task.toString()}'),
            ),
          );
        }
      });
}
