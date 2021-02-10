import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/user_bloc.dart';
import 'package:lima_enam/src/models/user_model.dart';
import 'package:lima_enam/src/resources/adapter/json_mahasiswa_adapter.dart';
import 'package:lima_enam/src/resources/adapter/mahasiswa_adapter.dart';
import 'package:lima_enam/src/ui/mahasiswa/nilaimhs/list_nilai_mahasiswa.dart';

class UserSection extends StatefulWidget {
  final NilaiMahasiswaAdapter adapter;
  final String headerText;

  const UserSection({
    @required this.adapter,
    @required this.headerText,
  }) : assert(headerText != null);

  _UserSectionState createState() => _UserSectionState();
}

class _UserSectionState extends State<UserSection> {
  void initState() {
    blocUser.fetchAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    blocUser.fetchAllUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text('Mahasiswa'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                openNilaiMahasiswa();
              }),
        ],
      ),
      body: StreamBuilder(
        stream: blocUser.allUsers,
        builder: (context, AsyncSnapshot<ItemModelUser> snapshot) {
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

  Widget buildList(AsyncSnapshot<ItemModelUser> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.results.length,
        itemBuilder: (BuildContext context, int index) {
          for (var i = index; i < snapshot.data.results.length; i++) {
            if (snapshot.data.results.elementAt(index).role != 'Mahasiswa') {
              snapshot.data.results
                  .removeWhere((element) => element.role != 'Mahasiswa');
              return Card(
                clipBehavior: null,
                semanticContainer: true,
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            '${snapshot.data.results[index].foto}'),
                      ),
                      title: Text(
                        '${snapshot.data.results[index].nama}',
                      ),
                      subtitle: Text(
                        '${snapshot.data.results[index].email.toString()}',
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Card(
                clipBehavior: null,
                semanticContainer: true,
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            '${snapshot.data.results[index].foto}'),
                      ),
                      title: Text(
                        '${snapshot.data.results[index].nama}',
                      ),
                      subtitle: Text(
                        '${snapshot.data.results[index].email.toString()}',
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        });
  }

  void openNilaiMahasiswa() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return NilaiMahasiswaList(
            adapter: JsonNilaiMahasiswaAdapter(),
            headerText: 'Nilai Mahasiswa');
      }),
    );
  }
}
