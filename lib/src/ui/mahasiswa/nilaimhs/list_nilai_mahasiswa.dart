import 'package:flutter/material.dart';
import 'package:lima_enam/src/models/mahasiswa_model.dart';
import 'package:lima_enam/src/resources/adapter/json_mahasiswa_adapter.dart';
import 'package:lima_enam/src/resources/adapter/mahasiswa_adapter.dart';
import 'package:lima_enam/src/ui/mahasiswa/nilaimhs/nilai_mahasiswa_section.dart';

class NilaiMahasiswaList extends StatefulWidget {
  final NilaiMahasiswaAdapter adapter;
  final String headerText;

  const NilaiMahasiswaList({
    @required this.adapter,
    @required this.headerText,
  })  : assert(adapter != null),
        assert(headerText != null);

  @override
  _NilaiMahasiswaListState createState() => _NilaiMahasiswaListState();
}

class _NilaiMahasiswaListState extends State<NilaiMahasiswaList> {
  final List<Mahasiswa> mahasiswas = List<Mahasiswa>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nilai Mahasiswa')),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: NilaiMahasiswaSection(
                    adapter: JsonNilaiMahasiswaAdapter(),
                    headerText: 'TI Pagi 2020'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: NilaiMahasiswaSection(
                    adapter: JsonNilaiMahasiswaAdapter(),
                    headerText: 'TI Pagi 2019'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
