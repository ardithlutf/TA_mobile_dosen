import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/tasks_bloc.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class UpdateTask extends StatefulWidget {
  final int id;
  final int sprint_id;
  final String nama_task;
  final int kesulitan_id;
  final bool status;

  UpdateTask(
      {this.id,
      this.nama_task,
      this.sprint_id,
      this.kesulitan_id,
      this.status});

  @override
  State<StatefulWidget> createState() => UpdateTaskState(
      id: id,
      sprint_id: sprint_id,
      nama_task: nama_task,
      kesulitan_id: kesulitan_id,
      status: status);
}

class UpdateTaskState extends State<UpdateTask> {
  @override
  void initState() {
    blocTask.fetchAllTasks();
    if (widget.sprint_id != null) {
      _isFieldSprintIDValid = true;
      _controllerSprintID.text = widget.sprint_id.toString();
      _isFieldNamaValid = true;
      _controllerNama.text = widget.nama_task;
      _isFieldKesulitanIDValid = true;
      _controllerKesulitanID.text = widget.kesulitan_id.toString();
    }
    super.initState();
  }

  bool _isFieldSprintIDValid;
  bool _isFieldNamaValid;
  bool _isFieldKesulitanIDValid;
  bool _isFieldStatusValid;
  bool _isLoading = false;

  TextEditingController _controllerSprintID = TextEditingController();
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerKesulitanID = TextEditingController();
  TextEditingController _controllerStatus = TextEditingController();

  final int id;
  final int sprint_id;
  final String nama_task;
  final int kesulitan_id;
  final bool status;

  UpdateTaskState(
      {this.id,
      this.nama_task,
      this.sprint_id,
      this.kesulitan_id,
      this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldState,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.nama_task == null ? "Form Sprint" : "Update Sprint",
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
                      labelText: "ProjectID",
                      errorText:
                          _isFieldSprintIDValid == null || _isFieldSprintIDValid
                              ? null
                              : "ProjectID is required",
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
