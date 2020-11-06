import 'dart:convert';

import 'package:lima_enam/src/models/mahasiswa_model.dart';
import 'package:lima_enam/src/resources/adapter/mahasiswa_adapter.dart';
import 'package:lima_enam/src/resources/json_mahasiswa_api.dart';

class JsonMahasiswaAdapter implements MahasiswaAdapter {
  final JsonMahasiswaApi _api = JsonMahasiswaApi();

  @override
  List<Mahasiswa> getMahasiswa() {
    var mahasiswaJson = _api.getMahasiswaJson();
    var mahasiswaList = _parsedMahasiswaJson(mahasiswaJson);

    return mahasiswaList;
  }

  List<Mahasiswa> _parsedMahasiswaJson(String mahasiswaJson) {
    var mahasiswaMap = json.decode(mahasiswaJson) as Map<String, dynamic>;
    var mahasiswaJsonList = mahasiswaMap['results'] as List;
    var mahasiswaList = mahasiswaJsonList
        .map((json) =>
            Mahasiswa(namaLengkap: json['nama lengkap'], email: json['email'],))
        .toList();

    return mahasiswaList;
  }
}
