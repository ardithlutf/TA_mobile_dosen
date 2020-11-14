import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/user_bloc.dart';
import 'package:lima_enam/src/models/user_model.dart';

class UserSection extends StatefulWidget {
  final String headerText;

  const UserSection({
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
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.list), onPressed: (){
        //     openNilaiMahasiswa();
        //   })
        // ],
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
        shrinkWrap: true,
        itemCount: snapshot.data.results.length,
        itemBuilder: (BuildContext context, int index) {
          //TODO:
          // Widget printMhs(){
          //   switch (snapshot.data.results[index].role){
          //     case "Mahasiswa":
          //       var mhs =  Text(
          //           '${snapshot.data.results[index].nama}',
          //           style:
          //           TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold));
          //       return mhs;
          //   break;
          //   case "Administrator":
          //     return Text(
          //         '${snapshot.data.results[index].nama}',
          //         style:
          //         TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold));
          //     break;
          //   }
          // }
          //
          // return printMhs();

          if (snapshot.data.results[index].role == 'Administrator') {
            return Card(
              clipBehavior: null,
              semanticContainer: true,
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '${snapshot.data.results[index].nama}',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${snapshot.data.results[index].email.toString()}',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
