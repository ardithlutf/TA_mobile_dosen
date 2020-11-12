import 'package:flutter/material.dart';
import 'package:lima_enam/src/ui/task/update_task.dart';
import '../../models/task_model.dart';
import '../../blocs/tasks_bloc.dart';
import 'create_task.dart';
import 'detail_task.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  void initState() {
    blocTask.fetchAllTasks();
    super.initState();
  }

  // @override
  // void dispose() {
  //   blocTask.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    blocTask.fetchAllTasks();
    return Scaffold(
      appBar: AppBar(
        title: Text('Sprint'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: (){
            openAddPage();
          })
        ],
      ),
      body: StreamBuilder(
        stream: blocTask.allTasks,
        builder: (context, AsyncSnapshot<ItemModelTask> snapshot) {
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

  Widget buildList(AsyncSnapshot<ItemModelTask> snapshot) {
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
                        '${snapshot.data.results[index].nama_task.toString()}',
                        style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETAIL'),
                          onPressed: (){
                            openDetailPage(snapshot.data, index);
                          },
                        ),
                        FlatButton(
                            child: const Text('HAPUS'),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Warning'),
                                      content: Text(
                                          'Anda ingin menghapus task ${snapshot.data.results[index].nama_task.toString()}'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Lanjut"),
                                          onPressed: () {
                                            blocTask.deleteTask(
                                                snapshot.data.results[index].id);
                                            Navigator.of(context).pop();
                                            setState(() {
                                              blocTask.fetchAllTasks();
                                            });
                                          },
                                        ),
                                        FlatButton(
                                          child: Text("Batal"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            }),
                        FlatButton(
                          child: const Text('EDIT'),
                          onPressed: (){
                            openUpdatePage(snapshot.data, index);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }

  openDetailPage(ItemModelTask data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return TaskDetail(
          id: data.results[index].id,
          nama_task: data.results[index].nama_task,
          sprint_id: data.results[index].sprint_id,
          kesulitan_id: data.results[index].kesulitan_id,
          status: data.results[index].status,
        );
      }),
    );
  }

  openAddPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return CreateTask();
      }),
    );
  }

  openUpdatePage(ItemModelTask data, int index){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return UpdateTask(
          id: data.results[index].id,
          nama_task: data.results[index].nama_task,
          sprint_id: data.results[index].sprint_id.toString(),
          kesulitan_id: data.results[index].kesulitan_id,
          status: data.results[index].status,
        );
      }),
    );
  }
}
