import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/projects_bloc.dart';
import 'package:lima_enam/src/blocs/sprints_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:lima_enam/src/resources/auth/shared_preferences_manager.dart';
import 'dart:convert';
import 'package:lima_enam/src/resources/injector/injector.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class UpdateSprint extends StatefulWidget {
  final int id;
  final String namaSprint;
  final String projectID;
  final String tglMulai;
  final String tglAkhir;

  UpdateSprint(
      {this.id, this.namaSprint, this.projectID, this.tglMulai, this.tglAkhir});

  @override
  State<StatefulWidget> createState() {
    return UpdateSprintState(
        id: id,
        namaSprint: namaSprint,
        projectID: projectID,
        tglMulai: tglMulai,
        tglAkhir: tglAkhir);
  }
}

class UpdateSprintState extends State<UpdateSprint> {
  final SharedPreferencesManager _sharedPreferencesManager =
      locator<SharedPreferencesManager>();

  final String baseurl = 'https://linkmatchsttnfapi.herokuapp.com';
  int _valProject;

  Future<String> getToken() async {
    final accessToken = _sharedPreferencesManager
        .getString(SharedPreferencesManager.keyAccessToken);
    return accessToken;
  }

  List<dynamic> _dataProject = List();

  void getProject() async {
    String token = await getToken();

    final response = await http.get("$baseurl/api/project",
        headers: {'Authorization': 'Bearer $token'});
    Map<String, dynamic> map = jsonDecode(response.body);
    List<dynamic> data = map["results"];
    setState(() {
      _dataProject = data;
    });
    print(data[0]["id"]);
  }

  final int id;
  final String projectID;
  final String namaSprint;
  final String tglMulai;
  final String tglAkhir;

  @override
  void initState() {
    blocProject.fetchAllProjects();
    blocSprint.fetchAllSprints();
    if (widget.projectID != null) {
      _isFieldNamaValid = true;
      _controllerNama.text = widget.namaSprint;
      _isFieldTglMulaiValid = true;
      _controllerTglMulai.text = widget.tglMulai.toString();
      _isFieldTglAkhirValid = true;
      _controllerTglAkhir.text = widget.tglAkhir.toString();
    }
    super.initState();
    getProject();
    blocSprint.insertProjectID(_valProject);
  }

  bool _isFieldNamaValid;
  bool _isFieldTglMulaiValid;
  bool _isFieldTglAkhirValid;
  bool _isLoading = false;

  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerTglMulai = TextEditingController();
  TextEditingController _controllerTglAkhir = TextEditingController();

  UpdateSprintState(
      {this.id, this.projectID, this.namaSprint, this.tglMulai, this.tglAkhir});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldState,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.namaSprint == null ? "Form Sprint" : "Update Sprint",
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
                      blocSprint.insertNamaSprint(value);
                    },
                  ),
                  DropdownButton(
                    dropdownColor: Colors.white,
                    hint: Text("Pilih Project"),
                    value: _valProject,
                    items: _dataProject.map((item) {
                      return DropdownMenuItem(
                        child: Text(item['nama']),
                        value: item['id'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _valProject = value;
                      });
                      blocSprint.insertProjectID(value);
                    },
                  ),
                  TextField(
                    controller: _controllerTglMulai,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Tanggal Mulai",
                      errorText:
                          _isFieldTglMulaiValid == null || _isFieldTglMulaiValid
                              ? null
                              : "Tanggal Mulai harus diisi",
                    ),
                    onChanged: (value) {
                      bool isFieldValid = value.trim().isNotEmpty;
                      if (isFieldValid != _isFieldTglMulaiValid) {
                        setState(() => _isFieldTglMulaiValid = isFieldValid);
                      }
                      blocSprint.insertTglMulai(value);
                    },
                  ),
                  TextField(
                    controller: _controllerTglAkhir,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Tanggal Akhir",
                      errorText:
                          _isFieldTglAkhirValid == null || _isFieldTglAkhirValid
                              ? null
                              : "Tanggal Akhir harus diisi",
                    ),
                    onChanged: (value) {
                      bool isFieldValid = value.trim().isNotEmpty;
                      if (isFieldValid != _isFieldTglAkhirValid) {
                        setState(() => _isFieldTglAkhirValid = isFieldValid);
                      }
                      blocSprint.insertTglAkhir(value);
                    },
                  ),
                  // TextField(
                  //   controller: _controllerStatus,
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //     labelText: "Status",
                  //     hintText: "Selesai, Belum",
                  //     errorText:
                  //         _isFieldStatusValid == null || _isFieldStatusValid
                  //             ? null
                  //             : "Status harus diisi",
                  //   ),
                  //   onChanged: (value) {
                  //     bool isFieldValid = value.trim().isNotEmpty;
                  //     if (isFieldValid != _isFieldStatusValid) {
                  //       setState(() => _isFieldStatusValid = isFieldValid);
                  //     }
                  //     blocSprint.insertStatus(value);
                  //   },
                  // ),
                  // DropdownButton<Status>(
                  //   value: Status.Belum,
                  //   items: Status.values.map((Status classType) {
                  //     return DropdownMenuItem<Status>(
                  //         value: classType, child: Text(classType.toString()));
                  //   }).toList(),
                  //   onChanged: (Status newValue) {
                  //     setState(() {
                  //       _valStatus = newValue as String;
                  //     });
                  //     blocSprint.insertStatus(newValue.toString());
                  //   },
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () async {
                        if (_isFieldNamaValid == null ||
                            _isFieldTglMulaiValid == null ||
                            _isFieldTglAkhirValid == null ||
                            // _isFieldStatusValid == null ||
                            !_isFieldNamaValid ||
                            !_isFieldTglMulaiValid ||
                            !_isFieldTglAkhirValid) {
                          _scaffoldState.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Please fill all field"),
                            ),
                          );
                          return;
                        }
                        setState(() {
                          _isLoading = true;
                        });
                        blocSprint.updateSaveSprint(id);
                        await Future.delayed(const Duration(milliseconds: 1699));
                        setState(() {
                          blocSprint.fetchAllSprints();
                        });
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
