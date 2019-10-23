import 'dart:developer';
import 'package:book_scanner/models/Book.dart';
import 'package:book_scanner/screens/book_detail_screen.dart';
import 'package:book_scanner/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

//TODO: Add an extra field for selecting the correct code type (ISBN, OCLC, LCCN or OLID.)

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  BookService _bookService = BookService();
  String barcode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(barcode == null
                  ? '📖 Please Scan a Barcode on a Book 📖'
                  : '$barcode'),
              RaisedButton(
                onPressed: scan,
                child: Text(barcode == null ? 'Scan' : 'Scan Another'),
              ),
              RaisedButton(
                child: Text('Look Up'),
                onPressed: barcode == null ? null : lookup,
              )
            ],
          ),
        ),
      ),
    );
  }

  void lookup() async {
    log(barcode);
    Book book = await _bookService.getBookDetails(barcode);
    if (book == null) {
      setState(() {
        barcode = 'Whoopsie, no data about this book online, try another!';
      });

      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailScreen(
          book: book,
        ),
      ),
    );
    // log(book.toString());
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
