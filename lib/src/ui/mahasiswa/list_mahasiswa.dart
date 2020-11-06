import 'package:flutter/material.dart';
import 'package:lima_enam/src/models/mahasiswa_model.dart';
import 'package:lima_enam/src/resources/adapter/json_mahasiswa_adapter.dart';
import 'package:lima_enam/src/resources/adapter/mahasiswa_adapter.dart';
import 'package:lima_enam/src/ui/mahasiswa/mahasiswa_card.dart';
import 'package:lima_enam/src/ui/mahasiswa/mahasiswa_section.dart';

class MahasiswaList extends StatefulWidget {
  final MahasiswaAdapter adapter;
  final String headerText;

  const MahasiswaList({
    @required this.adapter,
    @required this.headerText,
  })  : assert(adapter != null),
        assert(headerText != null);

  @override
  _MahasiswaListState createState() => _MahasiswaListState();
}

class _MahasiswaListState extends State<MahasiswaList> {
  final List<Mahasiswa> mahasiswas = List<Mahasiswa>();

  void _getMahasiswa() {
    setState(() {
      mahasiswas.addAll(widget.adapter.getMahasiswa());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mahasiswa'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: (){
            null;
          })
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: MahasiswaSection(adapter: JsonMahasiswaAdapter(), headerText: 'TI Pagi 2020'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: MahasiswaSection(adapter: JsonMahasiswaAdapter(), headerText: 'TI Pagi 2019'),
              ),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Task'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: (){
            null;
          })
        ],
      ),
    );
  }
}
