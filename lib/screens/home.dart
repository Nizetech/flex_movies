import 'dart:developer';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_movies/screens/details_screen.dart';
import 'package:flex_movies/screens/search_screen.dart';
import 'package:flex_movies/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    ApiService.getMovieCast(10);
    print('here');
    super.didChangeDependencies();
  }
  // @override
  // void initState() {
  //   var rng = new Random();
  //   var index = new List.generate(1, (_) => rng.nextInt(20));
  //   super.initState();
  // }
  // int index;

  // Random random = Random();
  int index = Random().nextInt(50);

  // int index = 50;

  Future<List> movieList = ApiService.getAllMovieList();
  // Future<List> movieSuggestion = ApiService.getMovieSuggestion(s);
  List movie = [];
  List suggestion = [];

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    print('index $index');
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,

      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
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
              hasScrollBody: false,
              child: FutureBuilder<dynamic>(
                  future: Future.wait([
                    movieList,
                    //  movieSuggestion
                    ApiService.getMovieSuggestion(index),
                    ApiService.getMovieCast(index)
                  ]),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      movie = snapshot.data[0];
                      suggestion = snapshot.data[1];
                      List cast = snapshot.data[2];
                      // log('my movies $movie');
                      return Column(
                        children: [
                          // SizedBox(height: 50),
                          GestureDetector(
                            onTap: () => Get.to(DetailsScreen(
                              movie: movie[0],
                              // cast: cast[0],
                            )),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: suggestion[0]['medium_cover_image'],
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
                                  child: Text(
                                    suggestion[0]['title'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  itemCount: movie.length,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          SizedBox(width: 20),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Map data = movie[index];

                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(DetailsScreen(
                                          movie: data,
                                          // cast: cast[index],
                                        ));
                                        // print('tapped==${movie[index]}');
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: movie[index]
                                            ['medium_cover_image'],
                                        // height: 130,
                                        // width: 130,
                                        fit: BoxFit.cover,
                                      ),
                                      //     Image.network(
                                      //   movie.isNotEmpty
                                      //       ? movie[index]['medium_cover_image']
                                      //       : Icon(Icons.image),
                                      //   fit: BoxFit.fill,
                                      //   height: 130,
                                      //   width: 130,
                                      // ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 40),
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Trending Movies',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
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
                                  itemCount: suggestion.length,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          SizedBox(width: 20),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CachedNetworkImage(
                                      imageUrl: suggestion[index]
                                          ['medium_cover_image'],
                                      height: 130,
                                      width: 130,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 40),
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Flex Movies',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
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
                                  itemCount: 6,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          SizedBox(width: 20),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Image.asset(
                                      'assets/img2.jpg',
                                      height: 130,
                                      width: 250,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        ],
                      );
                    }
                  })),
        ],
      ),
    );
  }
}
