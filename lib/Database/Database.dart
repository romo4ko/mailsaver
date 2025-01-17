import 'dart:math';

import 'package:mailsaver/Models/Email.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SQLiteHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;

    return await databaseFactory.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        onCreate: _onCreate,
        version: 1,
      ),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS emails(
            id INTEGER PRIMARY KEY,
            value TEXT,
            categoryId INTEGER,
            createdAt DATETIME
        )
    ''');
  }

  Future<Email> insert(Email email) async {
    final db = await database;

    db.insert(
      "emails",
      email.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return email;
  }

  Future<List<Email>> getAll() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('emails');

    return List.generate(maps.length, (index) {
      return Email(
        id: maps[index]['id'],
        value: maps[index]['value'],
        categoryId: maps[index]['categoryId'],
        createdAt: maps[index]['createdAt'],
      );
    });
  }

  Future<int> update(Email email) async {
    Database db = await database;
    return await db.update(
      'emails',
      email.toMap(),
      where: 'id = ?',
      whereArgs: [email.id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(
      'emails',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Email>> batchInsert() async {
    final db = await database;
    final batch = db.batch();
    final Random random = Random();
    final List<Email> userList = List.generate(
      1000,
      (index) => Email(
        id: index + 1,
        value: 'user$index@example.com',
        categoryId: 1,
        createdAt: DateTime.now().toString(),
      ),
    );
    for (final Email user in userList) {
      batch.insert(
        'emails',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
    return userList;
  }
}

extension on Email {
  Email fromMap(Map<String, dynamic> map) {
    return Email(
      id: map['id']?.toInt(),
      value: map['value'] ?? '',
      categoryId: map['categoryId'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }
}