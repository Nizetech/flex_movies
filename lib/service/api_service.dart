import 'dart:convert';
import 'dart:developer';

import 'package:flex_movies/key/api_key.dart';
import 'package:http/http.dart' as http;
import 'package:flex_movies/model/movie_list.dart';

class ApiService {
  static Future<List<Movie>?> getAllMovieList() async {
    try {
      var uri = Uri.https(ApiConstant.baseUrl, ApiConstant.movieList);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        // log('object ${response.body}');
        print('object ${response.body}');
        return MovieList.fromJson(jsonDecode(response.body)).movie;
      }
      return [];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
  // For Tesing if the endpoint is working ///

  // static Future<void> getAllMovie() async {
  //   var response =
  //       await http.get(Uri.parse('https://yts.mx/api/v2/list_movies.json'));
  //   print('response ${jsonDecode(response.body)}');
  // }
}
