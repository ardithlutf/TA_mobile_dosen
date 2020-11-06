import 'package:flutter/material.dart';
import 'package:lima_enam/src/models/mahasiswa_model.dart';
import 'package:lima_enam/src/resources/adapter/mahasiswa_adapter.dart';
import 'package:lima_enam/src/ui/mahasiswa/mahasiswa_card.dart';

class MahasiswaSection extends StatefulWidget {
  final MahasiswaAdapter adapter;
  final String headerText;

  const MahasiswaSection({
    @required this.adapter,
    @required this.headerText,
})  : assert(adapter != null),
      assert(headerText != null);

  _MahasiswaSectionState createState() => _MahasiswaSectionState();
}

class _MahasiswaSectionState extends State<MahasiswaSection> {
  final List<Mahasiswa> mahasiswas = List<Mahasiswa>();

  void _getMahasiswa() {
    setState(() {
      mahasiswas.addAll(widget.adapter.getMahasiswa());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.headerText, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
          const SizedBox(height: 8.0),
          Stack(
            children: <Widget>[
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: mahasiswas.length > 0 ? 1.0 : 0.0,
                child: Column(
                  children: <Widget>[
                    for (var mahasiswa in mahasiswas)
                      MahasiswaCard(
                        mahasiswa: mahasiswa,
                      )
                  ],
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: mahasiswas.length == 0 ? 1.0 : 0.0,
                child: FlatButton(
                  child: Text('Lihat mahasiswa', style: TextStyle(color: Colors.white),),
                  onPressed: _getMahasiswa,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}