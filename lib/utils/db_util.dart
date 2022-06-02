// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:great_place/models/place.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static Future<sql.Database> dataBase() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath, 'places'),
      onCreate: (db, int version) async {
        return await db.execute(
            // 'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT)');
            'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, date TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.dataBase();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.dataBase();
    return db.query(table);
  }

  static Future<int> delete(int id) async {
    final db = await DbUtil.dataBase();

    return await db.delete(
      'places',
      where: '$id= ?',
      whereArgs: [id],
    );
  }
}
