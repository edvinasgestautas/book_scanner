import 'package:book_scanner/BLOC/database_bloc.dart';
import 'package:book_scanner/models/Book.dart';
import 'package:book_scanner/screens/book_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BooksBloc>(context);
    bookProvider.getBooks();
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: StreamBuilder(
        stream: bookProvider.books,
        builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.hasData == false) {
            return Text('No Data Available');
          }

          List<Widget> listItems = [];

          snapshot.data.forEach((bookInstance) {
            listItems.add(
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailScreen(
                        book: bookInstance,
                        isFavoriteEnabled: false,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 60,
                  child: Card(
                    child: Center(
                      child: Text(
                          'ID: ${bookInstance.id} Title - ${bookInstance.title}'),
                    ),
                  ),
                ),
              ),
            );
          });
          if (listItems.isEmpty) {
            return Text(
                'Nothing To See Here, Go Scan a Book and Favourite It!');
          }
          return ListView(
            children: listItems,
          );
        },
      ),
    );
  }
}
