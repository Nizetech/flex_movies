import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../key/api_key.dart';
import '../../model/movie_list.dart';

class CategoryFetchController extends StateNotifier<AsyncValue<List<Movie>>> {
  CategoryFetchController() : super(const AsyncData([]));

  Future<void> getCategoryList(String genre, int page, int rating) async {
    try {
      state = const AsyncLoading();

      var uri = Uri.parse(
          '${ApiConstant.baseUrl}/api/v2/list_movies.json?sort_by=year&limit=20&genre=$genre&page=$page&minimum_rating=$rating');

      final response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      Map data = jsonDecode(response.body);
      final res = data['data']['movies'] as List;
      final movies = res.map((e) => Movie.fromJson(e)).toList();

      state = AsyncData(movies);
      // } else {
      //   return [];
      // }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final categoryFetchProvider =
    StateNotifierProvider<CategoryFetchController, AsyncValue<List<Movie>>>(
  (_) => CategoryFetchController(),
);
