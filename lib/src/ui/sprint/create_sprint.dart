import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:lima_enam/src/blocs/sprints_bloc.dart';
import 'package:intl/intl.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class CreateSprint extends StatefulWidget {
  final String nama_sprint;
  final String desc_sprint;

  CreateSprint({
    this.nama_sprint,
    this.desc_sprint,
  });

  @override
  State<StatefulWidget> createState() {
    return CreateSprintState(
      nama_sprint: nama_sprint,
      desc_sprint: desc_sprint,
    );
  }
}

class CreateSprintState extends State<CreateSprint> {
  final String nama_sprint;
  final desc_sprint;

  bool _isFieldNamaValid;
  bool _isFieldDeskripsiValid;
  bool _isFieldTglMulaiValid;
  bool _isFieldTglSelesaiValid;
  bool _isLoading = false;

  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerDeskripsi = TextEditingController();
  TextEditingController _controllerTglMulai = TextEditingController();
  TextEditingController _controllerTglSelesai = TextEditingController();

  CreateSprintState({
    this.nama_sprint,
    this.desc_sprint,
  });

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldState,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Tambah Project Baru",
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
                      labelText: "Judul Project",
                      errorText: _isFieldNamaValid == null || _isFieldNamaValid
                          ? null
                          : "Judul harus diisi",
                    ),
                    onChanged: (value) {
                      bool isFieldValid = value.trim().isNotEmpty;
                      if (isFieldValid != _isFieldNamaValid) {
                        setState(() => _isFieldNamaValid = isFieldValid);
                      }
                      blocSprint.insertJudul(value);
                    },
                  ),
                  TextField(
                    controller: _controllerDeskripsi,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Deskripsi",
                      errorText: _isFieldDeskripsiValid == null ||
                              _isFieldDeskripsiValid
                          ? null
                          : "Deskripsi harus diisi",
                    ),
                    onChanged: (value) {
                      bool isFieldValid = value.trim().isNotEmpty;
                      if (isFieldValid != _isFieldDeskripsiValid) {
                        setState(() => _isFieldDeskripsiValid = isFieldValid);
                      }
                      blocSprint.insertDesc(value);
                    },
                  ),
                  DateTimeField(
                      controller: _controllerTglMulai,
                      decoration: InputDecoration(
                        labelText: "Tanggal Mulai",
                        hintText: "YYYY-MM-DD",
                      ),
                      format: format,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                      onChanged: (value) {
                        bool isFieldValid = value.isAtSameMomentAs(value);
                        if (isFieldValid != _isFieldTglMulaiValid) {
                          setState(() => _isFieldTglMulaiValid = isFieldValid);
                        }
                        blocSprint.insertTglMulai(value.toString());
                      }),
                  DateTimeField(
                      controller: _controllerTglSelesai,
                      decoration: InputDecoration(
                        labelText: "Tanggal Selesai",
                        hintText: "YYYY-MM-DD",
                      ),
                      format: format,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                      onChanged: (value) {
                        bool isFieldValid = value.isAtSameMomentAs(value);
                        if (isFieldValid != _isFieldTglSelesaiValid) {
                          setState(
                              () => _isFieldTglSelesaiValid = isFieldValid);
                        }
                        blocSprint.insertTglSelesai(value.toString());
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () async {
                        blocSprint.addSaveSprint();
                        setState(() => _isLoading = true);
                        await Future.delayed(const Duration(milliseconds: 699));
                        Navigator.of(context).pop();
                        blocSprint.fetchAllSprints();
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
