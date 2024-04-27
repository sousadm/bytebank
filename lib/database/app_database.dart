import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dao/contato_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(ContatoDao.tableSql);
  }, version: 2, onDowngrade: onDatabaseDowngradeDelete);
}
