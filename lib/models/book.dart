enum BookStatus { available, borrowed }

class Book {
  String title;
  String author;
  String isbn;
  BookStatus status;

  Book({
    required this.title,
    required this.author,
    required this.isbn,
    this.status = BookStatus.available,
  });

  bool validateISBN() => isbn.length == 13;

  void updateStatus(BookStatus newStatus) {
    status = newStatus;
  }
}
