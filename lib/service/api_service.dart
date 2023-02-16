import 'dart:convert';
import 'dart:developer';

import 'package:flex_movies/key/api_key.dart';
import 'package:flex_movies/model/movie.dart' as movieDetails;
import 'package:http/http.dart' as http;
import 'package:flex_movies/model/movie_list.dart';

class ApiService {
  static Future<List> getAllMovieList() async {
    try {
      var uri = Uri.parse(ApiConstant.baseUrl + ApiConstant.movieList);

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
        Map data = jsonDecode(response.body);
        movie = data['data']['movies'];

        //    final data = jsonDecode(response.body) as Map<String, dynamic>;

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

  Future<List<Movie?>> getAllMovieListModel() async {
    print(ApiConstant.baseUrl + ApiConstant.movieList);
    var uri = Uri.parse(ApiConstant.baseUrl + ApiConstant.movieList);
    final response = await http.get(
      uri,
      // headers: {
      //   'Content-Type': 'application/json',
      // },
    );
    List<Movie> movie = [];
    if (response.statusCode == 200) {
      // log('object ${response.body}');
      // print('object ${response.body}');
      final data = jsonDecode(response.body);
      movie = MovieList.fromJson(data).data.movies;
      print(movie.first.title);

      print('my movie===> Movies model -===> ${movie.first.title}');
      return movie;
    } else {
      print('object');
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

  // Get movie movieCast
  static Future<List> getMovieCast(String movieID) async {
    // static Future<List<movieDetails.Cast>> getMovieCast(String movieID) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://yts.mx/api/v2/movie_details.json?sort_by=year?movie_id=$movieID&with_images=true&with_cast=true'),
      );
      List cast = [];
      // List<movieDetails.Cast>? cast = [];
      if (response.statusCode == 200) {
        log('movie Cast== ${response.body}');
        // print('object ${response.body}');
        Map data = jsonDecode(response.body);
        cast = data['data']['movie']['cast'];

        // final data = jsonDecode(response.body);
        // cast = movieDetails.Data.fromJson(data['data']).movie!.cast;
        print('my movie cast $cast');
        print('my cast length ${cast.length}');

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
