import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../key/api_key.dart';
import '../../model/movie.dart';

class AllMoviesFetcherController
    extends StateNotifier<AsyncValue<List<Movie>>> {
  AllMoviesFetcherController() : super(const AsyncData([]));

  Future<void> getAllMovieList(int page) async {
    try {
      state = const AsyncLoading();

      var uri = Uri.parse(
          '${ApiConstant.baseUrl}/api/v2/list_movies.json?sort_by=year&limit=20&page=$page');
      final response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      final data = json.decode(response.body);
      final res = data['data']['movies'] as List;
      final movies = res.map<Movie>((e) => Movie.fromMap(e)).toList();

      state = AsyncData(movies);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final allMoviesFetcherControllerProvider =
    StateNotifierProvider<AllMoviesFetcherController, AsyncValue<List<Movie>>>(
        (ref) {
  return AllMoviesFetcherController();
});
