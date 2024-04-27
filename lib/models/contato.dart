// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Contato {
  final int? id;
  final String nome;
  final String fone;
  final int idade;
  final String nascimento;

  Contato({
    this.id,
    required this.nome,
    required this.fone,
    required this.idade,
    required this.nascimento,
  });

  // Método estático para retornar um contato vazio
  static Contato empty() {
    return Contato(nome: '', fone: '', idade: 0, nascimento: '');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'fone': fone,
      'idade': idade,
      'nascimento': nascimento,
    };
  }

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['nome'] as String,
      fone: map['fone'] as String,
      idade: map['idade'] as int,
      nascimento: map['nascimento'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contato.fromJson(String source) =>
      Contato.fromMap(json.decode(source) as Map<String, dynamic>);
}
