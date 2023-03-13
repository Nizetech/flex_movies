import 'dart:developer';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_movies/key/api_key.dart';
import 'package:flex_movies/model/movie.dart' as movieDetails;
import 'package:flex_movies/screens/details_screen.dart';
import 'package:flex_movies/screens/search/search_screen.dart';
import 'package:flex_movies/screens/widgets/widgets.dart';
import 'package:flex_movies/service/api_service.dart';
import 'package:flex_movies/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/movie_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    // ApiService.getAllMovie();
    ApiService().searchMovie('thor');
    // ApiService.getMovieDetails('10');
    // ApiService.getAllMovieListModel();
    // ApiService().getAllMovieListModel(1);
    // print('here');
    super.didChangeDependencies();
  }

  static Box box = Hive.box(kAppName);

  int index = Random().nextInt(20);

  int page = 1;

  // List movie = [];
  Map<String, dynamic> movieData = {};
  Map<String, dynamic> movieDetails = {};
  Map movieId = {};
  List movieModel = [];
  List topMovies = [];
  List searchMovies = [];

  bool isSearching = false;
  // List<Map> watchlist = box.get('watchlist', defaultValue: {});

  @override
  Widget build(BuildContext context) {
    print('index $index');

    // print('watchlist ==> $watchlist');
    // print('cast ${cast}');
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,

      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // backgroundColor: Colors.black,
            scrolledUnderElevation: 0,

            stretchTriggerOffset: 10,
            title: const Text(
              'Flex Moviez',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () => Get.to(SearchScreen(
                      // movie: movie,
                      // suggestion: suggestion,
                      )),
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            // expandedHeight: 500,
            elevation: 0,
            // pinned: true,
            floating: true,
            snap: true,

            flexibleSpace: const FlexibleSpaceBar(
              expandedTitleScale: 1.1,
              titlePadding: EdgeInsets.zero,
              // title: Text(
              //   'HOme',
              // ),
            ),
          ),
          SliverFillRemaining(
              hasScrollBody: true,
              child: FutureBuilder<dynamic>(
                  future: Future.wait([
                    // ApiService().getAllMovieListModel(page),
                    ApiService.getAllMovieList(page),
                    ApiService.getTopMovies(page),

                    // cast,
                  ]),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData ||
                        snapshot.hasError ||
                        snapshot.data[1].length == 0) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      movieModel = snapshot.data[0];
                      topMovies = snapshot.data[1];

                      // print('topMovies===> ${searchMovies}');

                      movieModel.removeWhere(
                          // (element) => element.title == 'Mephistopheles');
                          (element) => element['title'] == 'Mephistopheles');
                      movieModel.shuffle();
                      topMovies.shuffle();
                      // print('topMovies $movieModel');
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                movieData.addAll({
                                  'large_cover_image': topMovies[index]
                                      ['large_cover_image'],
                                  'title': topMovies[index]['title'],
                                  'id': topMovies[index]['id'],
                                  'year': topMovies[index]['year'],
                                  'rating': topMovies[index]['rating'],
                                  'genres': topMovies[index]['genres'],
                                  'summary': topMovies[index]['summary'],
                                  'trailer': topMovies[index]['trailer'],
                                  'date_uploaded': topMovies[index]
                                      ['date_uploaded'],
                                  'description_full': topMovies[index]
                                      ['description_full'],
                                });
                                print(movieData);
                                Get.to(DetailsScreen(
                                  movie: movieData,
                                  // cast: cast[0],
                                ));
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: topMovies[index]
                                        ['large_cover_image'],
                                    errorWidget: (context, url, error) =>
                                        const Center(
                                      child: Text(
                                        'NO IMAGE AVAILABLE',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    height: 350,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                  Positioned(
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      height: 350,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black.withOpacity(.6),
                                            Colors.black.withOpacity(.4),
                                            Colors.transparent,
                                            Colors.transparent,
                                            Colors.black.withOpacity(.94),
                                            Colors.black,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: SizedBox(
                                      width: Get.width * .8,
                                      child: Text(
                                        topMovies[index]['title'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            // ActionTabs(
                            //   movie: topMovies[index],
                            // ),
                            SizedBox(height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Top Movies',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  height: 180,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: topMovies.length,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(width: 20),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return TopMovie(
                                        onTap: () {
                                          movieDetails.addAll({
                                            'id': topMovies[index]['id'],
                                          });

                                          Get.to(DetailsScreen(
                                            movie: movieDetails,
                                          ));
                                        },
                                        color: white,
                                        txtColor: Colors.black,
                                        movieSuggestion: topMovies,
                                        index: index,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 40),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Hot Movies',
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: movieModel.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          SizedBox(height: 20),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    List genres =
                                        movieModel[index]['genres'] == null
                                            ? []
                                            : movieModel[index]['genres'];
                                    // movieModel[index].genres;

                                    return HotMovie(
                                      onTap: () {
                                        movieDetails.addAll({
                                          'id': movieModel[index]['id'],
                                          // 'id': movieModel[index].id,
                                        });
                                        // return Get.to(
                                        //     DetailsScreen(movie: movieDetails));
                                      },
                                      index: index,
                                      // genres: [],
                                      genres: genres,
                                      movieModel: movieModel,
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (page > 1)
                                      TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red
                                                          .withOpacity(.8))),
                                          onPressed: () {
                                            page--;
                                            movieModel.clear();
                                            topMovies.clear();
                                            setState(() {});
                                          },
                                          child: Text(
                                            'Previous',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    SizedBox(width: 20),
                                    TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            mainColor.withOpacity(.8),
                                          ),
                                        ),
                                        onPressed: () {
                                          page++;
                                          movieModel.clear();
                                          topMovies.clear();
                                          setState(() {});
                                        },
                                        child: Text(
                                          'Next',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),

                                SizedBox(height: 20),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 20),
                                //   child: Wrap(
                                //     runSpacing: 10,
                                //     spacing: 20,
                                //     children: [
                                //       for (var i = 1; i < 50; i++)
                                //         GestureDetector(
                                //           onTap: () {
                                //             page + i;
                                //             setState(() {});
                                //             print('page No ===> $page');
                                //           },
                                //           child: Text(
                                //             i.toString() + '  ',
                                //             style: TextStyle(
                                //               decoration: page == i
                                //                   ? TextDecoration.underline
                                //                   : TextDecoration.none,
                                //               decorationThickness: 3,
                                //               decorationColor:
                                //                   page == i ? mainColor : white,
                                //               decorationStyle:
                                //                   TextDecorationStyle.solid,
                                //               fontSize: 14,
                                //               color: white,
                                //               fontWeight: FontWeight.bold,
                                //             ),
                                //           ),
                                //         ),
                                //     ],
                                //   ),
                                // ),

                                SizedBox(height: 30),
                              ],
                            ),
                            footer(),
                          ],
                        ),
                      );
                    }
                  })),
        ],
      ),
    );
  }
}
