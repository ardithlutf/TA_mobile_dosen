import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/sprints_bloc.dart';
import 'package:lima_enam/src/models/sprint_model.dart';
import 'package:lima_enam/src/ui/sprint/create_sprint.dart';

import 'detail_sprint.dart';
import 'update_sprint.dart';

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
                return Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return AddSprint();
                  }),
                );
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
                  subtitle: Text(
                    '${snapshot.data.results[index].projectId.toString()}',
                    style: TextStyle(fontSize: 15.0),
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
                                      onPressed: () async {
                                        blocSprint.deleteSprint(
                                            snapshot.data.results[index].id);
                                        await Future.delayed(const Duration(milliseconds: 699));
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

  @override
  void dispose() {
    super.dispose();
  }

  openUpdatePage(ItemModelSprint data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return UpdateSprint(
          id: data.results[index].id,
          namaSprint: data.results[index].nama,
          projectID: data.results[index].projectId.toString(),
          tglMulai: data.results[index].tanggalMulai,
          tglAkhir: data.results[index].tanggalAkhir,
        );
      }),
    );
  }

  openDetailPage(ItemModelSprint data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return SprintDetail(
          id: data.results[index].id,
          nama: data.results[index].nama,
          tanggalMulai: data.results[index].tanggalAkhir,
          tanggalAkhir: data.results[index].tanggalMulai,
          status: data.results[index].status,
        );
      }),
    );
  }
}
