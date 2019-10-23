import 'package:book_scanner/BLOC/database_bloc.dart';
import 'package:book_scanner/models/Book.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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
        title: Text('Favourites'),
      ),
      body: StreamBuilder(
        stream: bloc.clients,
        builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.hasData == false) {
            return Text('No Data');
          }

          List<Widget> listItems = [];

          snapshot.data.forEach((f) {
            listItems.add(GestureDetector(
              onTap: null,
              child: Card(
                child: Text(f.title),
              ),
            ));
          });

          return ListView(
            children: listItems,
          );
        },
      ),
    );
  }
}
