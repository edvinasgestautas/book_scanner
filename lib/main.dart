import 'package:book_scanner/BLOC/database_bloc.dart';
import 'package:book_scanner/models/Book.dart';
import 'package:book_scanner/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(
          value: BooksBloc(),
        ),
        StreamProvider<List<Book>>(
            builder: (context) =>
                Provider.of<BooksBloc>(context, listen: false).books)
      ],
      child: Consumer<BooksBloc>(
        builder: (context, bloc, child) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.purple,
            ),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
