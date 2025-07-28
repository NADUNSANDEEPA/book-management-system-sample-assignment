import 'package:flutter/material.dart';
import '../models/book.dart';

class AddBookScreen extends StatefulWidget {
  final Function(Book) onAddBook;
  AddBookScreen({required this.onAddBook});
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _author = '';
  String _isbn = '';
  BookStatus _status = BookStatus.available;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newBook = Book(
        title: _title,
        author: _author,
        isbn: _isbn,
        status: _status,
      );
      widget.onAddBook(newBook);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (val) => val!.isEmpty ? 'Enter title' : null,
                onSaved: (val) => _title = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Author'),
                validator: (val) => val!.isEmpty ? 'Enter author' : null,
                onSaved: (val) => _author = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'ISBN (13 digits)'),
                validator: (val) =>
                    val!.length != 13 ? 'ISBN must be 13 digits' : null,
                onSaved: (val) => _isbn = val!,
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<BookStatus>(
                value: _status,
                items: BookStatus.values.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _status = value!),
                decoration: InputDecoration(labelText: 'Status'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Add Book'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
