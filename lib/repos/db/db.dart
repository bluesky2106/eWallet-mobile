import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:eWallet/models/user.dart';

class DB {
  // Below codes are used to create a singleton instance of class DB
  static final DB _singleton = new DB._internal(); 

  factory DB() {
    return _singleton;
  }

  DB._internal();

  // Below codes are used to do CRUD
  Database _db;

  // Connect to database
  Future<void> open() async {
    if (_db == null || !_db.isOpen) {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'database.db');
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) {
          return db.execute(
            "CREATE TABLE users(ID INTEGER PRIMARY KEY, FullName TEXT, Email TEXT)",
          );
        },
      );
    }
  }

  // Create
  Future<void> insertUser(User user) async {
    await _db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve
  Future<List<User>> listUsers() async {
    final List<Map<String, dynamic>> users = await _db.query('users');
    if (users.length > 0) {
      users.map((userMap) => User.fromMap(userMap)).toList();
    }
    return null;
  }

  Future<User> selectUser() async {
    final List<Map<String, dynamic>> users = await _db.query('users');
    if (users.length > 0) {
      final Map<String, dynamic> userMap = users.last;
      return User.fromMap(userMap);
    }
    return null;
  }

  Future<User> selectUserByID(int id) async {
    List<Map> users = await _db.query('users', where: 'ID = ?', whereArgs: [id]);
    if (users.length > 0) {
      return User.fromMap(users.first);
    }
    return null;
  }

  // Update
  Future<int> updateUser(User user) async {
    return _db.update('users', user.toMap(), where: 'ID = ?', whereArgs: [user.id]);
  }

  // Delete
  Future<int> deleteUserByID(int id) async {
    return _db.delete('users', where: 'ID = ?', whereArgs: [id]);
  }

  Future<int> deleteAllUsers() async {
    return _db.delete('users');
  }
}