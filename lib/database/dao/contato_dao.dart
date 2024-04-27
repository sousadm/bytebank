import '../../models/contato.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class ContatoDao {

  static const String _tableName = 'contato';
  static const String tableSql =  'CREATE TABLE $_tableName ('
                                  'id INTEGER PRIMARY KEY, '
                                  'nome TEXT, '
                                  'fone TEXT, '
                                  'idade INTEGER)';

  Future<int> save(Contato contato) async {
    final Database db = await getDatabase();
    Map<String, dynamic> map = await contato.toMap();
    return db.insert(_tableName, map);
  }

  // Map<String, dynamic> _toMap(Contato contato) {
  //   final Map<String, dynamic> map = Map();
  //   map['nome'] = contato.nome;
  //   map['idade'] = contato.idade;
  //   map['fone'] = contato.fone;
  //   return map;
  // }

  Future<List<Contato>> findAll() async {
    final Database db = await getDatabase();
    List<Contato> contatos = await _toList(db);
    return contatos;
  }

  Future<List<Contato>> _toList(Database db) async {
    final List<Contato> contatos = <Contato>[];
    for (Map<String, dynamic> map in await db.query(_tableName)) {
      final Contato contato = Contato(id: map['id'], nome: map['nome'], fone: map['fone'], idade: map['idade']);
      contatos.add(contato);
    }
    return contatos;
  }

  Future<void> update(Contato contato) async {
    // Get a reference to the database.
    final db = await getDatabase();
    // Update the given Dog.
    await db.update(
      _tableName,
      contato.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [contato.id],
    );
  }

  Future<void> delete(Contato contato) async {
    // Get a reference to the database.
    final db = await getDatabase();

    // Remove the Dog from the database.
    await db.delete(
      _tableName,
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [contato.id],
    );
  }

}