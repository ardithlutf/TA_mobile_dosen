import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lima_enam/src/blocs/projects_bloc.dart';
import 'package:lima_enam/src/blocs/tasks_bloc.dart';
import 'package:lima_enam/src/models/project_model.dart';

class TaskDetail extends StatefulWidget {
  final int id;
  final int sprintID;
  final String namaTask;
  final int kesulitanID;
  final bool status;

  TaskDetail(
      {this.id, this.sprintID, this.namaTask, this.kesulitanID, this.status});

  @override
  State<StatefulWidget> createState() {
    return TaskDetailState(
        id: id,
        sprintID: sprintID,
        namaTask: namaTask,
        kesulitanID: kesulitanID,
        status: status);
  }
}

class TaskDetailState extends State<TaskDetail> {
  void initState() {
    blocProject.fetchAllProjects();
    super.initState();
  }

  @override
  void dispose() {
    // blocTask.dispose();
    super.dispose();
  }

  final int id;
  final int sprintID;
  final String namaTask;
  final int kesulitanID;
  final bool status;

  TaskDetailState(
      {this.id, this.sprintID, this.namaTask, this.kesulitanID, this.status});

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
                title: Center(
                  child: Text(
                    "$namaTask",
                  ),
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
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Anda ingin menghapus sprint:"),
                                    Text("$namaTask",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Lanjut",
                                        style: TextStyle(color: Colors.red)),
                                    onPressed: () {
                                      blocTask.deleteTask("$id");
                                      setState(() {
                                        Navigator.pop(context);
                                        blocTask.fetchAllTasks();
                                      });
                                      openTaskPage();
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
//                      "https://image.tmdb.org/t/p/w500/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg",
//                      fit: BoxFit.cover,
//                    )
//                    ),
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
                        Icons.book,
                        color: Colors.green,
                      ),
                      Container(
                        child: Text(
                          'Project',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 141,
                    child: Scaffold(
                      body: StreamBuilder(
                          stream: blocProject.allProjects,
                          builder: (context,
                              AsyncSnapshot<ItemModelProject> snapshot) {
                            if (snapshot.hasData) {
                              return buildSprint(snapshot, sprintID);
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            return Center(child: CircularProgressIndicator());
                          }),
                    ),
                  ),
                  // Tanggal Mulai
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
                                title: Text('DD/MM/YYYY'),
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
                                title: Text('DD/MM/YYYY'),
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

  Widget buildSprint(AsyncSnapshot<ItemModelProject> snapshot, sprintID) {
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
        primary: false,
        itemCount: snapshot.data.results.length,
        itemBuilder: (context, index) {
          if (snapshot.data.results[index].id == sprintID) {
            return Card(
              child: ListTile(
                title: Text('${snapshot.data.results[index].nama.toString()}'),
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
