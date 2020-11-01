import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/tasks_bloc.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class CreateTask extends StatefulWidget {
  final int sprint_id;
  final String nama_task;
  final int kesulitan_id;
  final bool status;

  CreateTask({
    this.nama_task,
    this.sprint_id,
    this.kesulitan_id,
    this.status
  });

  @override
  State<StatefulWidget> createState() {
    return CreateTaskState(
      sprint_id: sprint_id,
      nama_task: nama_task,
      kesulitan_id: kesulitan_id,
      status: status
    );
  }
}

class CreateTaskState extends State<CreateTask> {
  final int sprint_id;
  final String nama_task;
  final int kesulitan_id;
  final bool status;

  bool _isFieldSprintIDValid;
  bool _isFieldNamaValid;
  bool _isFieldKesulitanIDValid;
  bool _isFieldStatusValid;
  bool _isLoading = false;

  TextEditingController _controllerSprintID = TextEditingController();
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerKesulitanID = TextEditingController();
  TextEditingController _controllerStatus = TextEditingController();

  CreateTaskState({this.nama_task, this.sprint_id, this.kesulitan_id, this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldState,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Tambah Task Baru",
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
                  TextField(
                    controller: _controllerSprintID,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "SprintID",
                      errorText:
                          _isFieldSprintIDValid == null || _isFieldSprintIDValid
                              ? null
                              : "SprintID is required",
                    ),
                    onChanged: (value) {
                      bool isFieldValid = value.trim().isNotEmpty;
                      if (isFieldValid != _isFieldSprintIDValid) {
                        setState(() => _isFieldSprintIDValid = isFieldValid);
                      }
                      blocTask.insertSprintID(int.parse(value));
                    },
                  ),
                  TextField(
                    controller: _controllerNama,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Nama Task",
                      errorText: _isFieldNamaValid == null || _isFieldNamaValid
                          ? null
                          : "Nama Task is required",
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
                      errorText: _isFieldStatusValid == null ||
                          _isFieldStatusValid
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
                            _isFieldSprintIDValid == null ||
                            _isFieldKesulitanIDValid == null ||
                            _isFieldStatusValid == null ||
                            !_isFieldSprintIDValid ||
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
