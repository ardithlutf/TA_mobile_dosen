import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.results,
  });

  final Results results;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        results: Results.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "results": results.toJson(),
      };
}

class Results {
  Results({
    this.id,
    this.nama,
    this.role,
    this.username,
    this.email,
    this.foto,
    this.noHp,
  });

  final int id;
  final String nama;
  final String role;
  final String username;
  final String email;
  final String foto;
  final String noHp;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        id: json["id"],
        nama: json["nama"],
        role: json["role"],
        username: json["username"],
        email: json["email"],
        foto: json["foto"],
        noHp: json["no_hp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "role": role,
        "username": username,
        "email": email,
        "foto": foto,
        "no_hp": noHp,
      };
}
