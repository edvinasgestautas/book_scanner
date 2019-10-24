import 'dart:convert';
import 'package:book_scanner/models/Book.dart';
import 'package:http/http.dart' as http;

class BookService {
  final String basePath =
      'https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=';

  Future<Book> getBookDetails(String code) async {
    final result = await http.get('$basePath+$code');

    if (result.statusCode == 200 && result.body != '{}') {
      Map<String, dynamic> jayson = jsonDecode(result.body);
      return Book.fromJson(jayson.values
          .first); // Taking only the first because only one barcode can be sent by the app at a time, even though the API supports multiple
    } else {
      return null;
    }
  }
}
