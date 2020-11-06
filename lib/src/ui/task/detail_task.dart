import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lima_enam/src/blocs/sprints_bloc.dart';
import 'package:lima_enam/src/blocs/tasks_bloc.dart';
import 'package:lima_enam/src/models/sprint_model.dart';

class TaskDetail extends StatefulWidget {
  final int id;
  final int sprint_id;
  final String nama_task;
  final int kesulitan_id;
  final bool status;

  TaskDetail(
      {this.id,
      this.sprint_id,
      this.nama_task,
      this.kesulitan_id,
      this.status});

  @override
  State<StatefulWidget> createState() {
    return TaskDetailState(
        id: id,
        sprint_id: sprint_id,
        nama_task: nama_task,
        kesulitan_id: kesulitan_id,
        status: status);
  }
}

class TaskDetailState extends State<TaskDetail> {
  void initState() {
    blocSprint.fetchAllSprints();
    super.initState();
  }

  @override
  void dispose() {
    // blocTask.dispose();
    super.dispose();
  }

  final int id;
  final int sprint_id;
  final String nama_task;
  final int kesulitan_id;
  final bool status;

  TaskDetailState(
      {this.id,
      this.sprint_id,
      this.nama_task,
      this.kesulitan_id,
      this.status});

  @override
  Widget build(BuildContext context) {
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
                  "$nama_task",
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
                                    "Anda ingin menghapus task $nama_task"),
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
                                      blocTask.deleteTask("$id");
                                      setState(() {
                                        Navigator.pop(context);
                                        blocTask.fetchAllTasks();
                                      });
                                      openTaskPage();
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
//                      "https://image.tmdb.org/t/p/w500/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg",
//                      fit: BoxFit.cover,
//                    )
//                    ),
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
                                  child: Text('Test'))
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
                        'sprint',
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
                        stream: blocSprint.allSprints,
                        builder: (context, AsyncSnapshot<ItemModelSprint> snapshot) {
                          if (snapshot.hasData) {
                            return buildSprint(snapshot, sprint_id);
                            // return Expanded(
                            //   child: Container(
                            //     margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            //     height: 150,
                            //     width: double.maxFinite,
                            //     child: ListTile(
                            //       leading: Icon(Icons.wb_sunny),
                            //       title: Text('$id'),
                            //     ),
                            //   ),
                            // );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return Center(child: CircularProgressIndicator());
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSprint(AsyncSnapshot<ItemModelSprint> snapshot, sprint_id) {
    return ListView.builder(
        primary: false,
        itemCount: snapshot.data.results.length,
        itemBuilder: (context, index) {
          if (snapshot.data.results[index].id == sprint_id) {
            return Card(
              child: ListTile(
                title: Text('${snapshot.data.results[index].nama_sprint.toString()}'),
                //TODO: Sprint punya bbrp task
                subtitle: Text('${snapshot.data.results.length}'),
              ),
            );
          }
        });
  }

  openTaskPage() {
    var count = 0;

    Navigator.popUntil(context, (route) {
      return count++ == 1;
    });
  }
}
