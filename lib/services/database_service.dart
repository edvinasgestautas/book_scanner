import 'dart:async';
import 'dart:developer';
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
    // if _database is null we instantiate it
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
          "subtitle TEXT)");
    });
  }

  newBook(Book newBook) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Books");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Books (id,title,subtitle)"
        " VALUES (?,?,?)",
        [id, newBook.title, newBook.subtitle]);
    return raw;
  }

//   blockOrUnblock(Client client) async {
//     final db = await database;
//     Client blocked = Client(
//         id: client.id,
//         firstName: client.firstName,
//         lastName: client.lastName,
//         blocked: !client.blocked);
//     var res = await db.update("Client", blocked.toMap(),
//         where: "id = ?", whereArgs: [client.id]);
//     return res;
//   }

//   updateClient(Client newClient) async {
//     final db = await database;
//     var res = await db.update("Client", newClient.toMap(),
//         where: "id = ?", whereArgs: [newClient.id]);
//     return res;
//   }

//   getBook(int id) async {
//     final db = await database;
//     var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
//     return res.isNotEmpty ? Book.fromMap(res.first) : null;
//   }

//   Future<List<Client>> getBlockedClients() async {
//     final db = await database;

//     print("works");
//     // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
//     var res = await db.query("Client", where: "blocked = ? ", whereArgs: [1]);

//     List<Client> list =
//         res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
//     return list;
//   }

  Future<List<Book>> getAllBooks() async {
    final db = await database;
    var res = await db.query("Books");

    // res.forEach((f) {
    //   log(f.toString());
    //   Book test = Book.fromJson(f);
    //   log(test.toString());
    // });

    List<Book> list =
        res.isNotEmpty ? res.map((c) => Book.fromJson(c)).toList() : [];
    return list;
  }

//   deleteClient(int id) async {
//     final db = await database;
//     return db.delete("Client", where: "id = ?", whereArgs: [id]);
//   }

//   deleteAll() async {
//     final db = await database;
//     db.rawDelete("Delete * from Clinet");
//   }
}
