import 'dart:convert';

class Livro {
  String titulo;
  double nota;
  bool lido;

  Livro({required this.titulo, required this.nota, required this.lido});

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'nota': nota,
      'lido': lido,
    };
  }

  factory Livro.fromMap(Map<String, dynamic> map) {
    return Livro(
      titulo: map['titulo'],
      nota: map['nota'],
      lido: map['lido'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Livro.fromJson(String source) => Livro.fromMap(json.decode(source));
}
