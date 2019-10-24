import 'dart:async';
import 'dart:io';
import 'package:book_scanner/models/Book.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Books ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "subtitle TEXT,"
          "number_of_pages INTEGER)");
    });
  }

  newBook(Book newBook) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Books");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Books (id,title,subtitle,number_of_pages)"
        " VALUES (?,?,?,?)",
        [id, newBook.title, newBook.subtitle, newBook.numberOfPages]);
    return raw;
  }

// This might become problematic if someday there are thousands of books
  Future<List<Book>> getAllBooks() async {
    final db = await database;
    var res = await db.query("Books");
    List<Book> list = res.isNotEmpty
        ? res
            .map(
              (c) => Book.fromJson(c),
            )
            .toList()
        : [];
    return list;
  }

  deleteBook(int id) async {
    final db = await database;
    return db.delete("Books", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Books");
  }
}
