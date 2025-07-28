import 'package:flutter/material.dart';
import '../models/book.dart';
import 'add_book_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Book> books = [];
  final TextEditingController _searchController = TextEditingController();

  List<Book> get filteredBooks {
    if (_searchController.text.isEmpty) return books;
    return books
        .where((book) =>
            book.title
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            book.author
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
        .toList();
  }

  void _addBook(Book book) {
    setState(() => books.add(book));
  }

  void _removeBook(int index) {
    setState(() => books.removeAt(index));
  }

  void _toggleStatus(int index) {
    setState(() {
      final book = books[index];
      book.updateStatus(
        book.status == BookStatus.available
            ? BookStatus.borrowed
            : BookStatus.available,
      );
    });
  }

  void _navigateToAddBook() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddBookScreen(onAddBook: _addBook),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Manager'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by title or author',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredBooks.length,
        itemBuilder: (_, index) {
          final book = filteredBooks[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text('${book.author} | ${book.status.name}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.swap_horiz),
                  onPressed: () => _toggleStatus(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeBook(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddBook,
        child: Icon(Icons.add),
      ),
    );
  }
}
