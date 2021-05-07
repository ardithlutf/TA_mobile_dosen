import 'package:flutter/material.dart';
import '../../blocs/projects_bloc.dart';

class ProjectDetail extends StatefulWidget {
  final int id;
  final String nama;
  final String deskripsi;
  final String tanggalMulai;
  final String tanggalAkhir;
  final int jumlahSprint;
  final String budget;
  final String status;
  final String persen;
  final String productOwnerId;

  ProjectDetail(
      {this.id,
      this.nama,
      this.deskripsi,
      this.tanggalMulai,
      this.tanggalAkhir,
      this.jumlahSprint,
      this.budget,
      this.status,
      this.persen,
      this.productOwnerId});

  @override
  State<StatefulWidget> createState() {
    return ProjectDetailState(
        id: id,
        nama: nama,
        deskripsi: deskripsi,
        tanggalMulai: tanggalMulai,
        tanggalAkhir: tanggalAkhir,
        jumlahSprint: jumlahSprint,
        budget: budget,
        status: status,
        persen: persen,
        productOwnerId: productOwnerId);
  }
}

class ProjectDetailState extends State<ProjectDetail> {
  void initState() {
    blocProject.fetchAllProjects();
    super.initState();
  }

  final int id;
  final String nama;
  final String deskripsi;
  final String tanggalMulai;
  final String tanggalAkhir;
  final int jumlahSprint;
  final String budget;
  final String status;
  final String persen;
  final String productOwnerId;

  ProjectDetailState(
      {this.id,
      this.nama,
      this.deskripsi,
      this.tanggalMulai,
      this.tanggalAkhir,
      this.jumlahSprint,
      this.budget,
      this.status,
      this.persen,
      this.productOwnerId});

  @override
  Widget build(BuildContext context) {
    blocProject.fetchAllProjects();
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Center(
                  child: Text(
                    "$nama",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
//                flexibleSpace: FlexibleSpaceBar(
//                    background: Image.network(
//                  "https://image.tmdb.org/t/p/w500/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg",
//                  fit: BoxFit.cover,
//                )),
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
                        Icons.chat,
                        color: Colors.green,
                      ),
                      Container(
                        child: Text(
                          'Deskripsi',
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
                                    child: Text(deskripsi))
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
                                title: Text('$tanggalMulai'.toString()),
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
                                title: Text('$tanggalAkhir'.toString()),
                              ),
                            ),
                          ),
                        )
                      ])
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.chat,
                        color: Colors.green,
                      ),
                      Container(
                        child: Text(
                          'Product Owner',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    width: double.maxFinite,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        title: Text(productOwnerId),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.list,
                        color: Colors.green,
                      ),
                      Container(
                        child: Text(
                          'Sprint',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        margin: EdgeInsets.only(left: 1.0, right: 1.0),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    width: double.maxFinite,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        title: Text('Jumlah sprint: $jumlahSprint'),
                      ),
                    ),
                  ),
                  // Container(
                  //     height: 141,
                  //     child: Scaffold(
                  //       body: StreamBuilder(
                  //         stream: blocTask.allTasks,
                  //         builder:
                  //             (context, AsyncSnapshot<ItemModelTask> snapshot) {
                  //           if (snapshot.hasData) {
                  //             return buildListTask(snapshot, id);
                  //           } else if (snapshot.hasError) {
                  //             return Text(snapshot.error.toString());
                  //           }
                  //           return Center(child: CircularProgressIndicator());
                  //         },
                  //       ),
                  //     )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                  ),
                  Table(
                    children: [
                      TableRow(children: [
                        TableCell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.monetization_on_sharp,
                                color: Colors.green,
                              ),
                              Container(
                                child: Text(
                                  'Budget',
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
                                Icons.access_time_rounded,
                                color: Colors.green,
                              ),
                              Container(
                                child: Text(
                                  'Status',
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
                                title: Text('Rp.$budget,-'),
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
                                title: Text(status),
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

  @override
  void dispose() {
    super.dispose();
  }
}

// Widget buildListTask(AsyncSnapshot<ItemModelTask> snapshot, id) {
//   var panjangList = snapshot.data.results.length;
//
//   final icons = [
//     Icons.directions_bike,
//     Icons.directions_boat,
//     Icons.directions_bus,
//     Icons.directions_car,
//     Icons.directions_railway,
//   ];
//
//   return ListView.builder(
//       primary: false,
//       padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
//       itemCount: panjangList,
//       itemBuilder: (context, index) {
//         for (var i = index; i < panjangList; i++) {
//           if (snapshot.data.results.elementAt(index).sprintID == id) {
//             return Card(
//               child: ListTile(
//                 leading: Icon(icons[index]),
//                 title:
//                     Text('${snapshot.data.results[index].namaTask.toString()}'),
//               ),
//             );
//           } else {
//             snapshot.data.results
//                 .removeWhere((element) => element.sprintID != id);
//             return null;
//           }
//         }
//       });
// }
