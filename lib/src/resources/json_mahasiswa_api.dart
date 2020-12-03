class JsonMahasiswaApi {
  final String _mahasiswaJson = '''
  {
    "results": [
      {
        "nama lengkap": "Ardith Lutfiawan",
        "email": "ardith.lutfiawan@gmail.com",
        "role": "mahasiswa",
        "nilai": 93.0
      },
      {
        "nama lengkap": "Muhammad Akbar",
        "email": "muhakbar@gmail.com",
        "role": "mahasiswa",
        "nilai": 99.0
      },
      {
        "nama lengkap": "Huda Izzatul",
        "email": "izzatulhuda@gmail.com",
        "role": "mahasiswa",
        "nilai": 95.0
      }
    ]
  }
  ''';

  String getMahasiswaJson() {
    return _mahasiswaJson;
  }
}
