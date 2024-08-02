import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librarydb/core/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:librarydb/home/data/bookModel.dart';

part 'homeState.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<String> categories = ["Programming", "Science", "Business", "Education", "Entertainment", "Free Books"];
  List<BookModel> books = [];
  late BookModel currentBook;

  Future<void> getBooks(context, category) async {
    emit(HomeLoading());

    var url = Uri.parse("$baseUrl?q=$category&key=$apiKey&maxResults=40");

    try {
      var response = await http.get(url);
      var result = json.decode(response.body);

      if (response.statusCode == 200 && result["error"] == null) {
        emit(HomeSuccess());

        result["items"].forEach((book) {
          books.add(BookModel.fromJson(book));
        });

        debugPrint("Success");
      } else if (result["error"] != null) {
        emit(HomeError());
        debugPrint("API Error: $result}");
      } else {
        emit(HomeError());
        debugPrint("Request Error: ${response.statusCode}");
      }
    } catch(e) {
      emit(HomeError());
      debugPrint("Code Error: $e");
    }
  }
  Future<void> getBook(context, id) async {
    emit(HomeLoading());

    var url = Uri.parse("$baseUrl/$id?key=$apiKey");

    try {
      var response = await http.get(url);
      var result = json.decode(response.body);

      if (response.statusCode == 200 && result["error"] == null) {
        currentBook = BookModel.fromJson(result);

        emit(HomeSuccess());

        debugPrint("Success");
      } else if (result["error"] != null) {
        emit(HomeError());
        debugPrint("API Error: $result}");
      } else {
        emit(HomeError());
        debugPrint("Request Error: ${response.statusCode}");
      }
    } catch(e) {
      emit(HomeError());
      debugPrint("Code Error: $e");
    }
  }
}
