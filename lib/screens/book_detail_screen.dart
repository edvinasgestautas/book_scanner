import 'package:book_scanner/BLOC/database_bloc.dart';
import 'package:book_scanner/models/Book.dart';
import 'package:flutter/material.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;

  BookDetailScreen({@required this.book});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  final bloc = BooksBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              bloc.add(widget.book);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Text(
            widget.book.title,
          ),
        ),
      ),
    );
  }
}
