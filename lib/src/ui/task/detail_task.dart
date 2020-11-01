import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskDetail extends StatefulWidget {
  final int id;
  final int sprint_id;
  final String nama_task;
  final int kesulitan_id;
  final bool status;

  TaskDetail(
      this.id, this.sprint_id, this.nama_task, this.kesulitan_id, this.status);

  @override
  State<StatefulWidget> createState() {
    return TaskDetailState(
      id: id,
      sprint_id: sprint_id,
      nama_task: nama_task,
      kesulitan_id: kesulitan_id,
      status: status
    );
  }
}

class TaskDetailState extends State<TaskDetail> {
  final int id;
  final int sprint_id;
  final String nama_task;
  final int kesulitan_id;
  final bool status;

  TaskDetailState({
    this.id,
    this.sprint_id,
    this.nama_task,
    this.kesulitan_id,
    this.status
  });

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
                  IconButton(icon: Icon(Icons.delete), onPressed: null),
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
                        'TASK',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      margin: EdgeInsets.only(left: 1.0, right: 1.0),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    height: 150,
                    width: double.maxFinite,
                    child: ListTile(
                      leading: Icon(Icons.wb_sunny),
                      title: Text('Sun'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
