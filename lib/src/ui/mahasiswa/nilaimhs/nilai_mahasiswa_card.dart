import 'package:flutter/material.dart';
import 'package:lima_enam/src/models/mahasiswa_model.dart';

class NilaiMahasiswaCard extends StatelessWidget {
  final Mahasiswa mahasiswa;

  const NilaiMahasiswaCard({
    @required this.mahasiswa,
  }) : assert(mahasiswa != null);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Text(
              'Nama Lengkap',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
          ),
          DataColumn(
            label: Text(
              'Role',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'Nilai',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            numeric: true,
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text(mahasiswa.namaLengkap)),
              DataCell(Text(mahasiswa.role)),
              DataCell(Text(mahasiswa.nilai.toString())),
            ],
          ),
        ],
      ),
    );
  }
}
