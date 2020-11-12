import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/sprints_bloc.dart';
import 'package:lima_enam/src/blocs/tasks_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class CreateTask extends StatefulWidget {
  final String sprint_id;
  final String nama_task;
  final int kesulitan_id;
  final bool status;

  CreateTask({this.nama_task, this.sprint_id, this.kesulitan_id, this.status});

  @override
  State<StatefulWidget> createState() {
    return CreateTaskState(
        sprint_id: sprint_id,
        nama_task: nama_task,
        kesulitan_id: kesulitan_id,
        status: status);
  }
}

class CreateTaskState extends State<CreateTask> {
  final String baseurl = 'https://limastt.herokuapp.com';
  int _valProvince;

  List<dynamic> _dataProvince = List();

  void getProvince() async {
    final response = await http.get("$baseurl/api/sprints");
    Map<String, dynamic> map = jsonDecode(response.body);
    List<dynamic> data = map["results"];
    setState(() {
      _dataProvince = data;
    });
    print(data[0]["id"]);
  }

  String sprint_id;

  final String nama_task;
  final int kesulitan_id;
  final bool status;

  @override
  void initState() {
    blocSprint.fetchAllSprints();
    super.initState();
    getProvince();
  }

  bool _isFieldNamaValid;
  bool _isFieldKesulitanIDValid;
  bool _isFieldStatusValid;
  bool _isLoading = false;

  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerKesulitanID = TextEditingController();
  TextEditingController _controllerStatus = TextEditingController();

  CreateTaskState(
      {this.nama_task, this.sprint_id, this.kesulitan_id, this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldState,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Tambah Sprint Baru",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  DropdownButton(
                    hint: Text("Pilih Sprint"),
                    value: _valProvince,
                    items: _dataProvince.map((item) {
                      return DropdownMenuItem(
                        child: Text(item['nama_sprint']),
                        value: item['id'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valProvince = value;
                      });
                      blocTask.insertSprintID(value);
                    },
                  ),
                  // DropDownField(
                  //   controller: projectDipilih,
                  //   hintText: 'Pilih Project',
                  //   enabled: true,
                  //   items: blocSprint.ambilIDSprint(),
                  //   onValueChanged: (value) {
                  //     setState(() {
                  //       pilihproject = value;
                  //       blocTask.insertSprintID(int.parse(value));
                  //     });
                  //   },
                  // ),
                  // HomeScreensss(sprint_id),
                  // StreamBuilder(
                  //     stream: blocSprint.allSprints,
                  //     builder: (context, AsyncSnapshot<ItemModelSprint> snapshot) {
                  //       if (snapshot.hasData){
                  //         return DropDownField(
                  //           controller: projectDipilih,
                  //           hintText: 'Pilih Project',
                  //           enabled: true,
                  //           items: blocSprint.ambilIDSprint(sprint_id),
                  //           onValueChanged: (value) {
                  //             setState(() {
                  //               pilihproject = value;
                  //               blocTask.insertSprintID(int.parse(value));
                  //             });
                  //           },
                  //         );
                  //         // return DropdownButton(
                  //         //   hint: Text('Pilih Project'),
                  //         //   value: snapshot.data.hasil,
                  //         //   items: blocSprint
                  //         //       .ambilSprintID(sprint_id)
                  //         //       .map((item) => DropdownMenuItem(
                  //         //       child: Row(children: <Widget>[
                  //         //         Text("$sprint_id"),
                  //         //       ]))),
                  //         //   onChanged: (value) {
                  //         //     setState(() {
                  //         //       pilihproject = value;
                  //         //       blocTask.insertSprintID(int.parse(value));
                  //         //     });
                  //         //   },
                  //         // );
                  //       } else if (snapshot.hasError) {
                  //         return Text(snapshot.error.toString());
                  //       }
                  //       return Center(child: CircularProgressIndicator());
                  //
                  //     }),
                  // TextField(
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //     labelText: "ProjectID",
                  //   ),
                  //   onChanged: (value) {
                  //     blocTask.insertSprintID(int.parse(value));
                  //   },
                  // ),
                  TextField(
                    controller: _controllerNama,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Nama Sprint",
                      errorText: _isFieldNamaValid == null || _isFieldNamaValid
                          ? null
                          : "Nama Sprint is required",
                    ),
                    onChanged: (value) {
                      bool isFieldValid = value.trim().isNotEmpty;
                      if (isFieldValid != _isFieldNamaValid) {
                        setState(() => _isFieldNamaValid = isFieldValid);
                      }
                      blocTask.insertJudul(value);
                    },
                  ),
                  TextField(
                    controller: _controllerKesulitanID,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Kesulitan ID",
                      hintText: "",
                      errorText: _isFieldKesulitanIDValid == null ||
                              _isFieldKesulitanIDValid
                          ? null
                          : "Kesulitan ID is required",
                    ),
                    onChanged: (value) {
                      bool isFieldValid = value.trim().isNotEmpty;
                      if (isFieldValid != _isFieldKesulitanIDValid) {
                        setState(() => _isFieldKesulitanIDValid = isFieldValid);
                      }
                      blocTask.insertKesulitanID(int.parse(value));
                    },
                  ),
                  TextField(
                    controller: _controllerStatus,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Status",
                      hintText: "1/0",
                      errorText:
                          _isFieldStatusValid == null || _isFieldStatusValid
                              ? null
                              : "Status is required",
                    ),
                    onChanged: (value) {
                      bool isFieldValid = value.trim().isNotEmpty;
                      if (isFieldValid != _isFieldStatusValid) {
                        setState(() => _isFieldStatusValid = isFieldValid);
                      }
                      blocTask.insertStatus(bool.fromEnvironment(value));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () async {
                        if (_isFieldNamaValid == null ||
                            _isFieldKesulitanIDValid == null ||
                            _isFieldStatusValid == null ||
                            !_isFieldNamaValid ||
                            !_isFieldKesulitanIDValid ||
                            !_isFieldStatusValid) {
                          _scaffoldState.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Please fill all field"),
                            ),
                          );
                          return;
                        }
                        blocTask.addSaveTask();
                        setState(() => _isLoading = true);
                        await Future.delayed(const Duration(milliseconds: 699));
                        blocTask.fetchAllTasks();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Simpan'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.orange[600],
                    ),
                  ),
                ],
              ),
            ),
            _isLoading
                ? Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.3,
                        child: ModalBarrier(
                          dismissible: false,
                          color: Colors.grey,
                        ),
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  )
                : Container(),
          ],
        ));
  }
}

// Widget DropdownSprint(AsyncSnapshot<ItemModelSprint> snapshot) {
//   return DropdownButtonFormField(
//       value: ,
//       items: snapshot.data.results
//           .map((item) => DropdownMenuItem(
//               value: sprint_id, child: Text(item.nama_sprint.toString())))
//           .toList(),
//       onChanged: (newValue) {
//         setState(() {
//           sprint_id = newValue;
//         });
//         blocTask.insertSprintID(int.parse(newValue));
//       },
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
//         filled: true,
//         fillColor: Colors.grey[200],
// // hintText: Localization.of(context).category,
// // errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null),
//       ));
// }

//TODO:
