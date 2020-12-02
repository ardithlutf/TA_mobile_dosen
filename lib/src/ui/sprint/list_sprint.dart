import 'package:flutter/material.dart';
import '../../models/sprint_model.dart';
import '../../blocs/sprints_bloc.dart';
import 'create_sprint.dart';
import 'detail_sprint.dart';

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
        title: Text('Project'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                openAddPage();
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
                    '${snapshot.data.results[index].nama_sprint.toString()}',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
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
                  ],
                ),
              ],
            ),
          ));
        });
  }

  openAddPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return CreateSprint();
      }),
    );
  }

  openDetailPage(ItemModelSprint data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return SprintDetail(
          id: data.results[index].id,
          nama_sprint: data.results[index].nama_sprint,
          desc_sprint: data.results[index].desc_sprint,
          tgl_mulai: data.results[index].tgl_mulai,
          tgl_selesai: data.results[index].tgl_selesai,
        );
      }),
    );
  }
}
