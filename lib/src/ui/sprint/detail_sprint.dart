import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/tasks_bloc.dart';
import 'package:lima_enam/src/models/task_model.dart';
import '../../blocs/sprints_bloc.dart';

class SprintDetail extends StatefulWidget {
  final int id;
  final String desc_sprint;
  final String nama_sprint;

  SprintDetail({
    this.id,
    this.nama_sprint,
    this.desc_sprint,
  });

  @override
  State<StatefulWidget> createState() {
    return SprintDetailState(
      id: id,
      nama_sprint: nama_sprint,
      desc_sprint: desc_sprint,
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
  final String desc_sprint;
  final String nama_sprint;

  SprintDetailState({
    this.id,
    this.nama_sprint,
    this.desc_sprint,
  });

  @override
  Widget build(BuildContext context) {
    blocTask.fetchAllTasks();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text(
                  "$nama_sprint",
                  style: TextStyle(color: Colors.black),
                ),
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.edit), onPressed: null),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Warning'),
                                content: Text(
                                    "Anda ingin menghapus sprint $nama_sprint dengan id = $id"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Batal"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("Lanjut"),
                                    onPressed: () {
                                      blocSprint.deleteSprint("$id");
                                      setState(() {
                                        Navigator.of(context).pop();
                                      });
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.bookmark,
                      color: Colors.green,
                    ),
                    Container(
                      child: Text(
                        'DESKRIPSI',
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
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.list,
                      color: Colors.green,
                    ),
                    Container(
                      child: Text(
                        'TASK',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      margin: EdgeInsets.only(left: 1.0, right: 1.0),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    height: 350,
                    child: Scaffold(
                      body: StreamBuilder(
                        stream: blocTask.allTasks,
                        builder:
                            (context, AsyncSnapshot<ItemModelTask> snapshot) {
                          if (snapshot.hasData) {
                            return buildListTask(snapshot);
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _myListView(BuildContext context) {
  final titles = [
    'bike',
    'boat',
    'bus',
    'car',
    'railway',
    'run',
    'subway',
    'transit',
    'walk'
  ];

  final icons = [
    Icons.directions_bike,
    Icons.directions_boat,
    Icons.directions_bus,
    Icons.directions_car,
    Icons.directions_railway,
    Icons.directions_run,
    Icons.directions_subway,
    Icons.directions_transit,
    Icons.directions_walk
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

Widget buildListTask(AsyncSnapshot<ItemModelTask> snapshot) {
  final icons = [
    Icons.directions_bike,
    Icons.directions_boat,
    Icons.directions_bus,
    Icons.directions_car,
    Icons.directions_railway,
    Icons.directions_run,
    Icons.directions_subway,
    Icons.directions_transit,
    Icons.directions_walk
  ];

  return ListView.builder(
      itemCount: snapshot.data.results.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Icon(icons[index]),
            title: Text('${snapshot.data.results[index].nama_task.toString()}'),
            subtitle: Text('${snapshot.data.results[index].sprint_id.toString()}'),
          ),
        );
      });
}
