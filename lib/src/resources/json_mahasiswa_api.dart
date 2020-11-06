class JsonMahasiswaApi {
  final String _mahasiswaJson = '''
  {
    "results": [
      {
        "nama lengkap": "Ardith Lutfiawan",
        "email": "ardith.lutfiawan@gmail.com"
      },
      {
        "nama lengkap": "Muhammad Akbar",
        "email": "muhakbar@gmail.com"
      },
      {
        "nama lengkap": "Huda Izzatul",
        "email": "izzatulhuda@gmail.com"
      }
    ]
  }
  ''';

  String getMahasiswaJson() {
    return _mahasiswaJson;
  }
}