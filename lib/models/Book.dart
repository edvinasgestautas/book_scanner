class Book {
  final String title;
  final String subtitle;

  Book({this.title, this.subtitle});

// TODO: This has to be refactored if we want to parse more than one book at a time,
// also this was done because the endpoint returns book number as a key and the data json
// as a value.
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
    );
  }
}
