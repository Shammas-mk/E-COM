import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE product(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        productName TEXT,
        strapColor TEXT,
        highLight TEXT,
        productPrice INTEGER,
        status TEXT
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'product.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String productName, String? strapColor,
      String? highLight, int? productPrice, String? status) async {
    final db = await SQLHelper.db();

    final data = {
      'productName': productName,
      'strapColor': strapColor,
      'highLight': highLight,
      'productPrice': productPrice,
      'status': status,
    };
    final id = await db.insert('product', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('product', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('product', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
    int id,
    String productName,
    String? strapColor,
    String? highLight,
    int? productPrice,
    String? status,
  ) async {
    final db = await SQLHelper.db();

    final data = {
      'productName': productName,
      'strapColor': strapColor,
      'highLight': highLight,
      'productPrice': productPrice,
      'status': status,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('product', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("product", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
