import 'package:flutter/material.dart';
import 'package:lima_enam/src/models/mahasiswa_model.dart';

class MahasiswaCardold extends StatelessWidget {
  final Mahasiswa mahasiswa;

  const MahasiswaCardold({
    @required this.mahasiswa,
  }) : assert(mahasiswa != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(mahasiswa.namaLengkap),
        subtitle: Text(mahasiswa.email),
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          foregroundColor: Colors.white,
          child: Text(mahasiswa.namaLengkap[0]),
        ),
      ),
    );
  }
}
