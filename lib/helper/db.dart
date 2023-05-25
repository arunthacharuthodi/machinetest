import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "cart.db";
  static const _databaseVersion = 1;

  static const table = 'UserTable';

  static const id = 'id';
  static const count = 'count';
  static const updated_at = 'updated_at';

  late Database _db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE UserTable (
      id INTEGER,
      title VARCHAR NOT NULL,
      price VARCHAR NOT NULL,
      description VARCHAR NOT NULL,
      category VARCHAR NOT NULL,
      image VARCHAR NOT NULL,
      count VARCHAR NOT NULL
    )
  ''');
  }

  //increment cart
  Future<void> incrementCart(int id) async {
    await _db.rawUpdate(
      'UPDATE $table SET count = count + 1 WHERE id = ?',
      [id],
    );
    final List<Map<String, dynamic>> records = await _db.query(table);

    for (final record in records) {
      print(record);
    }
  }

  // Future<int> addToCart(Map<String, dynamic> row) async {
  //   return await _db.insert(table, row);
  // }
  Future<int> addToCart(Map<String, dynamic> row) async {
    final existingRow =
        await _db.query(table, where: 'id = ?', whereArgs: [row['id']]);

    if (existingRow.isNotEmpty) {
      String exstcount = existingRow[0]['count'] as String;
      final updatedCount = int.parse(exstcount) + 1;
      return await _db.update(table, {'count': updatedCount},
          where: 'id = ?', whereArgs: [row['id']]);
    } else {
      return await _db.insert(table, row);
    }
  }

  Future<int> removeFromCart(int id) async {
    final existingRow =
        await _db.query(table, where: 'id = ?', whereArgs: [id]);

    String exstcount = existingRow[0]['count'] as String;
    if (int.parse(exstcount) > 1) {
      final updatedCount = int.parse(exstcount) - 1;
      return await _db.update(table, {'count': updatedCount},
          where: 'id = ?', whereArgs: [id]);
    } else {
      return await _db.delete(table, where: 'id = ?', whereArgs: [id]);
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(table);
  }

  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT * FROM $table');
    return results.length ?? 0;
  }

  Future<int> update(Map<String, dynamic> row) async {
    int id = row['id'];
    return await _db.update(
      table,
      row,
      where: '$id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    return await _db.delete(
      table,
      where: '$id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deletedb() async {
    try {
      _db.execute('''
DROP TABLE $table
''');
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final resp = await _db.rawQuery('SELECT * FROM $table');
    print(resp);
    return resp;
  }
}
