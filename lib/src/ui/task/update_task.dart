import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/projects_bloc.dart';
import 'package:lima_enam/src/blocs/tasks_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class UpdateTask extends StatefulWidget {
  final int id;
  final String namaTask;
  final String sprintID;
  final int kesulitanID;
  final bool status;

  UpdateTask(
      {this.id, this.namaTask, this.sprintID, this.kesulitanID, this.status});

  @override
  State<StatefulWidget> createState() => UpdateTaskState(
      id: id,
      namaTask: namaTask,
      sprintID: sprintID,
      kesulitanID: kesulitanID,
      status: status);
}

class UpdateTaskState extends State<UpdateTask> {
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
    // print(data[0]["id"]);
  }

  // void getSprintID() async {
  //   final response = await http.get("$baseurl/api/sprints");
  // }

  final int id;
  final String sprintID;
  final String namaTask;
  final int kesulitanID;
  final bool status;

  @override
  void initState() {
    blocProject.fetchAllProjects();
    blocTask.fetchAllTasks();
    if (widget.sprintID != null) {
      _isFieldNamaValid = true;
      _controllerNama.text = widget.namaTask;
      _isFieldKesulitanIDValid = true;
      _controllerKesulitanID.text = widget.kesulitanID.toString();
    }
    super.initState();
    getProvince();
    blocTask.insertSprintID(_valProvince);
  }

  bool _isFieldNamaValid;
  bool _isFieldKesulitanIDValid;
  bool _isFieldStatusValid;
  bool _isLoading = false;

  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerKesulitanID = TextEditingController();
  TextEditingController _controllerStatus = TextEditingController();

  UpdateTaskState(
      {this.id, this.namaTask, this.sprintID, this.kesulitanID, this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldState,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.namaTask == null ? "Form Sprint" : "Update Sprint",
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
                    dropdownColor: Colors.white,
                    hint: Text("Pilih Project"),
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
                  TextField(
                    controller: _controllerNama,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Nama Sprint",
                      errorText: _isFieldNamaValid == null || _isFieldNamaValid
                          ? null
                          : "Nama Sprint harus diisi",
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
                          : "Kesulitan ID harus diisi",
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
                              : "Status harus diisi",
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
                        blocTask.updateSaveTask(id);
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
