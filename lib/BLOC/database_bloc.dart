import 'dart:async';

import 'package:book_scanner/models/Book.dart';
import 'package:book_scanner/services/database_service.dart';

class BooksBloc {
  final _bookController = StreamController<List<Book>>.broadcast();

  get books => _bookController.stream;

  dispose() {
    _bookController.close();
  }

  getBooks() async {
    _bookController.sink.add(
      await DBProvider.db.getAllBooks(),
    );
  }

  BooksBloc() {
    getBooks();
  }

  delete(int id) {
    DBProvider.db.deleteBook(id);
    getBooks();
  }

  add(Book book) {
    DBProvider.db.newBook(book);
    getBooks();
  }
}
