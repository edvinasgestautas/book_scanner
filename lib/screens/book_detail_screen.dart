import 'package:book_scanner/BLOC/database_bloc.dart';
import 'package:book_scanner/models/Book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;
  final bool isFavoriteEnabled;

  BookDetailScreen({@required this.book, @required this.isFavoriteEnabled});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BooksBloc>(context);
    bookProvider.getBooks();
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: <Widget>[
          widget.isFavoriteEnabled
              ? IconButton(
                  icon: Icon(Icons.star),
                  onPressed: () {
                    bookProvider.add(widget.book);
                  },
                )
              : IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    bookProvider.delete(widget.book.id);
                    Navigator.pop(context);
                  },
                )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Title - ${widget.book.title}',
                ),
                Text('Subtitle - ${widget.book.subtitle}'),
                Text(
                  'Number of pages - ${widget.book.numberOfPages.toString()}',
                ),
                Text('Date published - ${widget.book.publishingDate}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
