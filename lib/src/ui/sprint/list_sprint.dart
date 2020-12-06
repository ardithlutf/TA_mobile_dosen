import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/sprints_bloc.dart';
import 'package:lima_enam/src/models/sprint_model.dart';

class SprintList extends StatefulWidget {
  @override
  _SprintListState createState() => _SprintListState();
}

class _SprintListState extends State<SprintList> {
  void initState() {
    blocSprint.fetchAllSprints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    blocSprint.fetchAllSprints();
    return Scaffold(
      appBar: AppBar(
        title: Text('Sprint'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                return null;
              })
        ],
      ),
      body: StreamBuilder(
        stream: blocSprint.allSprints,
        builder: (context, AsyncSnapshot<ItemModelSprint> snapshot) {
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

  Widget buildList(AsyncSnapshot<ItemModelSprint> snapshot) {
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
                          child: const Text('DETAIL'),
                          onPressed: () {
                            return null;
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
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text("Anda ingin menghapus sprint:"),
                                          Text(
                                              "${snapshot.data.results[index].nama.toString()}",
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
                                            blocSprint.deleteSprint(
                                                snapshot.data.results[index].id);
                                            Navigator.of(context).pop();
                                            setState(() {
                                              blocSprint.fetchAllSprints();
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
                          onPressed: () {
                            return null;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
