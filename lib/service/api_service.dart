import 'dart:convert';
import 'dart:developer';

import 'package:flex_movies/key/api_key.dart';
import 'package:flex_movies/model/movie.dart' as movieDetails;
import 'package:http/http.dart' as http;
import 'package:flex_movies/model/movie_list.dart';

class ApiService {
  static Future<List> getAllMovieList(int page) async {
    try {
      var uri = Uri.parse(ApiConstant.baseUrl +
          '/api/v2/list_movies.json?sort_by=year&limit=20&page=$page');

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

  static Future<List> getTopMovies(int page) async {
    try {
      var uri = Uri.parse(ApiConstant.baseUrl +
          '/api/v2/list_movies.json?sort_by=download_count&page=$page');

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      List movie = [];
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        movie = data['data']['movies'];

        // print('my Top MOvie==> $movie');
        return movie;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<Movie?>> getAllMovieListModel(int page) async {
    try {
      var uri = Uri.parse(ApiConstant.baseUrl +
          // '/api/v2/list_movies.json?sort_by=year&limit=20&page=$page');
          '/api/v2/list_movies.json?sort_by=year&limit=20&page=1');
      final response = await http.get(
        uri,
        // headers: {
        //   'Content-Type': 'application/json',
        // },
      );
      List<Movie> movie = [];
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // print(response.body);
        movie = MovieList.fromJson(data).data.movies;
        print(movie.first.title);

        print('my movie===> Movies model -===> ${movie.first.title}');
        print('hot movies $movie');
        return movie;
      } else {
        print('object');
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Get searchMovie
  Future<List> searchMovie(String searchQuery) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://yts.mx//api/v2/list_movies.json?query_term=$searchQuery'),
      );
      List searchMovie = [];
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        // log(response.body);
        // print(response.body);
        // searchMovie = MovieList.fromJson(data).data.movies;
        searchMovie = data['data']['movies'];

        print('my movie===> Movies Search -===> ${searchMovie}}');
        return searchMovie;
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

  // Get movie movieCast
  static Future<Map> getMovieDetails(String movieID) async {
    // static Future<List<movieDetails.Cast>> getMovieCast(String movieID) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://yts.mx/api/v2/movie_details.json?movie_id=$movieID&with_images=true&with_cast=true'),
      );
      Map cast = {};
      // List<movieDetails.Cast>? cast = [];
      if (response.statusCode == 200) {
        log('movie Cast== ${response.body}');
        // print('object ${response.body}');
        Map data = jsonDecode(response.body);
        cast = data['data']['movie'];

        // final data = jsonDecode(response.body);
        // cast = movieDetails.Data.fromJson(data['data']).movie!.cast;
        print('my movie cast $cast');
        print('my cast length ${cast.length}');

        return cast;
      } else {
        return {};
      }
    } catch (e) {
      print(e.toString());
      return {};
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
  //       Uri.parse('https://yts.mx//api/v2/list_movies.json?query_term=thor'));
  //   print('response ${jsonDecode(response.body)}');
  // }
}
