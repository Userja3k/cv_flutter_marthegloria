import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../models/family_member.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cv_marthegloria.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE family_members (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        job TEXT NOT NULL,
        image TEXT NOT NULL
      )
    ''');

    // Identifiant: Admin, Mot de passe: admin123
    await db.insert('users', {
      'username': 'Admin',
      'password': 'admin123',
    });

    // Membres initiaux
    await db.insert('family_members', {
      'name': 'Elige M.',
      'job': 'Père • Commerçant',
      'image': 'assets/images/P.png',
    });
    await db.insert('family_members', {
      'name': 'Françoise R.',
      'job': 'Mère • Enseignante',
      'image': 'assets/images/M.png',
    });
    await db.insert('family_members', {
      'name': 'Israel B.',
      'job': 'Frère • Étudiant',
      'image': 'assets/images/G.jpg',
    });
  }

  // --- Authentification ---
  Future<bool> login(String username, String password) async {
    final db = await database;
    final res = await db.query(
      'users',
      where: 'LOWER(username) = LOWER(?) AND password = ?',
      whereArgs: [username.trim(), password],
    );
    return res.isNotEmpty;
  }

  // --- CRUD Membres de la famille ---
  Future<List<FamilyMember>> getFamilyMembers() async {
    final db = await database;
    final result = await db.query('family_members', orderBy: 'id ASC');
    return result.map((e) => FamilyMember.fromMap(e)).toList();
  }

  Future<int> insertFamilyMember(FamilyMember member) async {
    final db = await database;
    return await db.insert('family_members', member.toMap());
  }

  Future<int> updateFamilyMember(FamilyMember member) async {
    final db = await database;
    return await db.update(
      'family_members',
      member.toMap(),
      where: 'id = ?',
      whereArgs: [member.id],
    );
  }

  Future<int> deleteFamilyMember(int id) async {
    final db = await database;
    return await db.delete(
      'family_members',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
