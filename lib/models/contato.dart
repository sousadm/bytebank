import 'dart:convert';

class Contato {
  final int? id;
  final String nome;
  final String fone;
  final int idade;

  Contato({
    this.id,
    required this.nome,
    required this.fone,
    required this.idade,
  });

  // Método estático para retornar um contato vazio
  static Contato empty() {
    return Contato(nome: '', fone: '', idade: 0);
  }

  @override
  String toString() {
    return 'Contato(id: $id, nome: $nome, fone: $fone, idade: $idade)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'fone': fone,
      'idade': idade,
    };
  }

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['nome'] as String,
      fone: map['fone'] as String,
      idade: map['idade'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contato.fromJson(String source) =>
      Contato.fromMap(json.decode(source) as Map<String, dynamic>);
}
