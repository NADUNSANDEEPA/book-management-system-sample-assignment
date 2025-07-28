import 'book.dart';

class TextBook extends Book {
  String subjectArea;
  String gradeLevel;

  TextBook({
    required String title,
    required String author,
    required String isbn,
    required this.subjectArea,
    required this.gradeLevel,
  }) : super(title: title, author: author, isbn: isbn);
}
