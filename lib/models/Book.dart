class Book {
  final int id;
  final String title;
  final String subtitle;
  final int numberOfPages;
  final String publishingDate;

  Book({
    this.id,
    this.title,
    this.subtitle,
    this.numberOfPages,
    this.publishingDate,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      numberOfPages: json['number_of_pages'] ?? 0,
      publishingDate: json['publish_date'] ?? '',
    );
  }
}
