import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lima_enam/src/blocs/projects_bloc.dart';
import 'package:lima_enam/src/blocs/sprints_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:lima_enam/src/resources/auth/shared_preferences_manager.dart';
import 'dart:convert';
import 'package:lima_enam/src/resources/injector/injector.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AddSprint extends StatefulWidget {
  final String projectID;
  final String namaSprint;
  final String tglMulai;
  final String tglAkhir;

  AddSprint({this.projectID, this.namaSprint, this.tglMulai, this.tglAkhir});

  @override
  State<StatefulWidget> createState() {
    return AddSprintState(
        projectID: projectID,
        namaSprint: namaSprint,
        tglMulai: tglMulai,
        tglAkhir: tglAkhir);
  }
}

class AddSprintState extends State<AddSprint> {
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

  final String projectID;
  final String namaSprint;
  final String tglMulai;
  final String tglAkhir;

  @override
  void initState() {
    blocProject.fetchAllProjects();
    super.initState();
    getProject();
  }

  bool _isFieldNamaValid;
  bool _isFieldTglMulaiValid;
  bool _isFieldTglAkhirValid;
  bool _isLoading = false;

  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerTglMulai = TextEditingController();
  TextEditingController _controllerTglAkhir = TextEditingController();

  AddSprintState(
      {this.projectID, this.namaSprint, this.tglMulai, this.tglAkhir});

  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                      print(value.runtimeType);
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
                      print(value.runtimeType);
                      blocSprint.insertProjectID(value);
                    },
                  ),
                  DateTimeField(
                    controller: _controllerTglMulai,
                    format: format,
                    decoration: InputDecoration(
                      labelText: "Tanggal Mulai",
                      errorText:
                      _isFieldTglMulaiValid == null || _isFieldTglMulaiValid
                          ? null
                          : "Tanggal Mulai harus diisi",
                    ),
                    onShowPicker: (context, value) async {
                      final date = await showDatePicker(
                          context: context,
                          initialDate: value ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      return date;
                    },
                    onChanged: (date) {
                      bool isFieldValid = true;
                      if (isFieldValid != _isFieldTglMulaiValid) {
                        setState(() => _isFieldTglMulaiValid = isFieldValid);
                      }
                      print(date.runtimeType);
                      blocSprint.insertTglMulai(date.toString());
                    },
                  ),
                  DateTimeField(
                    controller: _controllerTglAkhir,
                    format: format,
                    decoration: InputDecoration(
                      labelText: "Tanggal Akhir",
                      errorText:
                      _isFieldTglAkhirValid == null || _isFieldTglAkhirValid
                          ? null
                          : "Tanggal Akhir harus diisi",
                    ),
                    onShowPicker: (context, value) async {
                      final date =  await showDatePicker(
                          context: context,
                          initialDate: value ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      return date;
                    },
                    onChanged: (date) {
                      bool isFieldValid = true;
                      if (isFieldValid != _isFieldTglAkhirValid) {
                        setState(() => _isFieldTglAkhirValid = isFieldValid);
                      }
                      print(date.runtimeType);
                      blocSprint.insertTglAkhir(date.toString());
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () async {
                        if (_isFieldNamaValid == null ||
                            _isFieldTglMulaiValid == null ||
                            _isFieldTglAkhirValid == null ||
                            !_isFieldNamaValid ||
                            !_isFieldTglMulaiValid ||
                            !_isFieldTglAkhirValid
                        ) {
                          _scaffoldState.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Data tidak boleh kosong!"),
                            ),
                          );
                          return;
                        }
                        setState(() {
                          _isLoading = true;
                        });
                        blocSprint.addSaveSprint();
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
