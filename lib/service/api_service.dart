import 'dart:convert';
import 'dart:developer';

import 'package:flex_movies/key/api_key.dart';
import 'package:http/http.dart' as http;
import 'package:flex_movies/model/movie_list.dart';

class ApiService {
  static Future<List> getAllMovieList() async {
    try {
      var uri = Uri.https(ApiConstant.baseUrl, ApiConstant.movieList);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      List movie = [];
      if (response.statusCode == 200) {
        // log('object ${response.body}');
        // print('object ${response.body}');
        final data = jsonDecode(response.body);
        movie = data['data']['movies'];
        //    final data = jsonDecode(response.body) as Map<String, dynamic>;
        // movie = MovieList.fromJson(data).data.toJson()['movies'];
        // print('my movie $movie');
        return movie;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Get movie suggestion
  static Future<List> getMovieSuggestion(int index) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://yts.mx/api/v2/movie_suggestions.json?movie_id=$index'),
      );
      List movieSuggestion = [];
      if (response.statusCode == 200) {
        // log('movie Suggestion== ${response.body}');
        // print('object ${response.body}');
        Map data = jsonDecode(response.body);
        movieSuggestion = data['data']['movies'];
        // print('my movie Suggestion $movieSuggestion');
        return movieSuggestion;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Get movie suggestion
  static Future<List> getMovieCast(int index) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://yts.mx/api/v2/movie_details.json?movie_id=10&with_images=true&with_cast=true'),
      );
      List cast = [];
      if (response.statusCode == 200) {
        // log('movie Suggestion== ${response.body}');
        // print('object ${response.body}');
        Map data = jsonDecode(response.body);
        cast = data['data']['movies'];
        print('my movie cast $cast');
        return cast;
      } else {
        return [];
      }
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

  // static Future<void> getAllMovie() async {
  //   var response = await http.get(
  //       Uri.parse('https://yts.mx/api/v2/movie_suggestions.json?movie_id=10'));
  //   print('response ${jsonDecode(response.body)}');
  // }
}
