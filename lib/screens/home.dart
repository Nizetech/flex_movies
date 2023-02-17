import 'dart:developer';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_movies/model/movie.dart' as movieDetails;
import 'package:flex_movies/screens/details_screen.dart';
import 'package:flex_movies/screens/search_screen.dart';
import 'package:flex_movies/screens/widgets/widgets.dart';
import 'package:flex_movies/service/api_service.dart';
import 'package:flex_movies/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../model/movie_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    ApiService.getMovieDetails('10');
    // ApiService.getAllMovieListModel();
    print('here');
    super.didChangeDependencies();
  }

  static const _pageSize = 20;

  int index = Random().nextInt(20);

  // Future<List> movieList = ApiService.getAllMovieList(page);
  int page = 1;

  List movie = [];
  Map<String, dynamic> movieData = {};
  Map<String, dynamic> movieDetails = {};

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    print('index $index');
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
                    // movieList,
                    ApiService().getAllMovieListModel(page),
                    // cast,
                  ]),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      // movie = snapshot.data[0];
                      // suggestion = snapshot.data[1];
                      List movieModel = snapshot.data[0];
                      // genre= movieModel[];
                      // print(movieModel.length.toString());
                      // List<movieDetails.Cast?> castImg = snapshot.data[3];
                      // Map cast = snapshot.data[3];

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                movieData.addAll({
                                  'large_cover_image':
                                      movieModel[index].largeCoverImage,
                                  'title': movieModel[index].title,
                                  'id': movieModel[index].id,
                                  'year': movieModel[index].year,
                                  'rating': movieModel[index].rating,
                                  'genres': movieModel[index].genres,
                                  'summary': movieModel[index].summary,
                                  'trailer': movieModel[index].ytTrailerCode,
                                  'date_uploaded':
                                      movieModel[index].dateUploaded,
                                  'description_full':
                                      movieModel[index].descriptionFull,
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
                                    imageUrl: movieModel[index].largeCoverImage,
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
                                        movieModel[index].title,
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      const CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Color(0xff212029),
                                        child: Icon(
                                          Icons.add,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Watchlist',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Color(0xff212029),
                                        child: Icon(
                                          Icons.add,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Watchlist',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Color(0xff212029),
                                        child: Icon(
                                          Icons.add,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Watchlist',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
                                  height: 130,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: movieModel.length,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(width: 20),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                          onTap: () {
                                            movieDetails.addAll({
                                              'id': movieModel[index].id,
                                            });

                                            Get.to(DetailsScreen(
                                              movie: movieDetails,
                                            ));
                                          },
                                          child: CachedNetworkImage(
                                            errorWidget:
                                                (context, url, error) =>
                                                    SizedBox(),

                                            imageUrl: movieModel[index]
                                                .mediumCoverImage,

                                            // height: 130,
                                            // width: 130,
                                            fit: BoxFit.cover,
                                          ));
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
                                    List<String> genres =
                                        movieModel[index].genres;
                                    return HotMovie(
                                      index: index,
                                      genres: genres,
                                      movieModel: movieModel,
                                    );
                                  },
                                ),
                                Row(
                                  children: [
                                    Center(
                                      child: TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      mainColor)),
                                          onPressed: () {
                                            setState(() {
                                              movieModel.clear();
                                              page++;
                                            });
                                          },
                                          child: Text(
                                            'Next',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
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
