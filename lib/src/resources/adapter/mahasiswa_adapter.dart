import 'package:lima_enam/src/models/mahasiswa_model.dart';

abstract class MahasiswaAdapter {
  List<Mahasiswa> getMahasiswa();
}

abstract class NilaiMahasiswaAdapter {
  List<Mahasiswa> getNilaiMahasiswa();
}
