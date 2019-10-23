import 'package:book_scanner/screens/camera_screen.dart';
import 'package:book_scanner/screens/favourite_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CameraScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavouriteScreen()));
            },
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            'Please use the 📷 or ⭐️ icons above to either scan a new barcode and look up a book or to go trough your favourites.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
