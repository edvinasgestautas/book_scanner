import 'dart:async';

import 'package:book_scanner/models/Book.dart';
import 'package:book_scanner/services/database_service.dart';

class BooksBloc {
  final _clientController = StreamController<List<Book>>.broadcast();

  get clients => _clientController.stream;

  dispose() {
    _clientController.close();
  }

  getClients() async {
    _clientController.sink.add(await DBProvider.db.getAllBooks());
  }

  BooksBloc() {
    getClients();
  }

  // blockUnblock(Client client) {
  //   DBProvider.db.blockOrUnblock(client);
  //   getClients();
  // }

  // delete(int id) {
  //   DBProvider.db.deleteClient(id);
  //   getClients();
  // }

  add(Book client) {
    DBProvider.db.newBook(client);
    getClients();
  }
}
