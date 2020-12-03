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
        .map((json) => Mahasiswa(
            namaLengkap: json['nama lengkap'],
            email: json['email'],
            role: json['role'],
            nilai: json['nilai']))
        .toList();

    return mahasiswaList;
  }
}

class JsonNilaiMahasiswaAdapter implements NilaiMahasiswaAdapter {
  final JsonMahasiswaApi _api = JsonMahasiswaApi();

  @override
  List<Mahasiswa> getNilaiMahasiswa() {
    var nilaimahasiswaJson = _api.getMahasiswaJson();
    var mahasiswaNilai = _parsedNilaiMahasiswaJson(nilaimahasiswaJson);

    return mahasiswaNilai;
  }

  List<Mahasiswa> _parsedNilaiMahasiswaJson(String mahasiswaJson) {
    var mahasiswaMap = json.decode(mahasiswaJson) as Map<String, dynamic>;
    var mahasiswaJsonList = mahasiswaMap['results'] as List;
    var mahasiswaNilai = mahasiswaJsonList
        .map((json) => Mahasiswa(
            namaLengkap: json['nama lengkap'],
            role: json['role'],
            nilai: json['nilai']))
        .toList();

    return mahasiswaNilai;
  }
}
