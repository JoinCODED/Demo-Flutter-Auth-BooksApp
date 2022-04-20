import 'dart:async';
import 'dart:io';
import 'package:books_app/models/book.dart';
import 'package:books_app/services/client.dart';
import "package:dio/dio.dart";
import 'package:shared_preferences/shared_preferences.dart';

class BooksServices {
  Future<List<Book>> getBooks() async {
    List<Book> books = [];
    try {
      Response response = await Client.dio.get('/books');
      books =
          (response.data as List).map((book) => Book.fromJson(book)).toList();
    } on DioError catch (error) {
      print(error);
    }
    return books;
  }

  Future<Book> createBook({required Book book}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";

    // _dio.options.headers = {
    //   HttpHeaders.authorizationHeader: 'Bearer $token',
    // };

    late Book retrievedBook;
    try {
      FormData data = FormData.fromMap({
        "title": book.title,
        "description": book.title,
        "price": book.price,
        "image": await MultipartFile.fromFile(
          book.image,
        ),
      });
      Response response = await Client.dio.post('/books', data: data);
      retrievedBook = Book.fromJson(response.data);
    } on DioError catch (error) {
      print(error);
    }
    return retrievedBook;
  }

  Future<Book> updateBook({required Book book}) async {
    late Book retrievedBook;
    try {
      FormData data = FormData.fromMap({
        "title": book.title,
        "description": book.title,
        "price": book.price,
        "image": await MultipartFile.fromFile(
          book.image,
        ),
      });
      print(book.id);

      Response response = await Client.dio.put('/books/${book.id}', data: data);
      retrievedBook = Book.fromJson(response.data);
    } on DioError catch (error) {
      print(error);
    }
    return retrievedBook;
  }

  Future<void> deleteBook({required int bookId}) async {
    try {
      await Client.dio.delete('/books/${bookId}');
    } on DioError catch (error) {
      print(error);
    }
  }
}
