import 'package:flutter/material.dart';
import '../../models/project_model.dart';
import '../../blocs/projects_bloc.dart';
import 'detail_project.dart';

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
      ),
      body: StreamBuilder(
        stream: blocSprint.allSprints,
        builder: (context, AsyncSnapshot<ItemModelProject> snapshot) {
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

  Widget buildList(AsyncSnapshot<ItemModelProject> snapshot) {
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

  openDetailPage(ItemModelProject data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return SprintDetail(
          id: data.results[index].id,
          nama: data.results[index].nama,
          deskripsi: data.results[index].deskripsi,
          tanggalMulai: data.results[index].tanggalAkhir,
          tanggalAkhir: data.results[index].tanggalMulai,
          jumlahSprint: data.results[index].jumlahSprint,
          budget: data.results[index].budget,
          status: data.results[index].status,
          persen: data.results[index].persen,
          productOwnerId: data.results[index].productOwnerId,
        );
      }),
    );
  }
}
