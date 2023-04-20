import 'dart:developer';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_apps/device_apps.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flex_movies/model/movie.dart' as movieDetails;
import 'package:flex_moviez/screens/home/widget.dart';
import 'package:flex_moviez/screens/search/search_screen.dart';
import 'package:flex_moviez/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/movie_list.dart';
import '../../service/provider/watch_list_provider.dart';
import '../../utils/colors.dart';
import '../../utils/utils.dart';
import '../common/widget.dart';
import '../movie_details/details_screen.dart';
import '../widgets/download.dart';
import '../widgets/widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  final int index;
  HomePage({Key? key, required this.index}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    initDynamicLinks(context: context);
    super.initState();
  }

  int page = 1;
  Map<String, dynamic> movieData = {};
  Map<String, dynamic> movieDetails = {};
  Map movieId = {};
  List movieModel = [];
  List topMovies = [];
  List searchMovies = [];

  final ScrollController _controller = ScrollController();

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    bool isConnected = ref.watch(internetProvider);
    Future<List> getAllMovies = ApiService.getAllMovieList(widget.index);
    Future<List> getTopMovies = ApiService.getTopMovies(widget.index);

    print('index ${widget.index}');

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // backgroundColor: Colors.black,
            scrolledUnderElevation: 0,

            stretchTriggerOffset: 10,
            // leadingWidth: 10,
            leading: Transform.scale(
              scale: .7,
              child: Image.asset(
                'assets/logo.png',
                height: 20,
                width: 20,
              ),
            ),
            title: Transform.translate(
              offset: Offset(-10, 0),
              child: Text(
                'Flex Moviez',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
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
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: !isConnected
                ? FutureBuilder<dynamic>(
                    future: Future.wait([
                      getAllMovies,
                      getTopMovies,
                    ]),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.hasError ||
                          // isConnected == true ||
                          snapshot.data[1].length == 0) {
                        return Center(child: loader());
                      } else {
                        movieModel = snapshot.data[0];
                        topMovies = snapshot.data[1];

                        movieModel.removeWhere(
                            (element) => element['title'] == 'Mephistopheles');

                        topMovies.shuffle();

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  movieData.addAll({
                                    'large_cover_image': topMovies[widget.index]
                                        ['large_cover_image'],
                                    'title': topMovies[widget.index]['title'],
                                    'id': topMovies[widget.index]['id'],
                                    'year': topMovies[widget.index]['year'],
                                    'rating': topMovies[widget.index]['rating'],
                                    'genres': topMovies[widget.index]['genres'],
                                    'summary': topMovies[widget.index]
                                        ['summary'],
                                    'trailer': topMovies[widget.index]
                                        ['trailer'],
                                    'date_uploaded': topMovies[widget.index]
                                        ['date_uploaded'],
                                    'description_full': topMovies[widget.index]
                                        ['description_full'],
                                  });
                                  print(movieData);
                                  Get.to(DetailsScreen(
                                    movie: movieData,
                                  ));
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: topMovies[widget.index]
                                          ['large_cover_image'],
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        color: Colors.black,
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
                                          topMovies[widget.index]['title'],
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
                              ActionTabs(
                                movie: {
                                  'id':
                                      topMovies[widget.index]['id'].toString(),
                                  'title': topMovies[widget.index]['title'],
                                  'large_cover_image': topMovies[widget.index]
                                      ['large_cover_image'],
                                  'rating': topMovies[widget.index]['rating'],
                                  'genres': topMovies[widget.index]['genres'],
                                  'isFavorite': true,
                                },
                                controller: _controller,
                                imageUrl: topMovies[widget.index]
                                    ['large_cover_image'],
                                movieTitle: topMovies[widget.index]['title'],
                                isHome: true,
                                trailerCode: topMovies[widget.index]
                                    ['yt_trailer_code'],
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
                                    height: 250,
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
                                  SizedBox(height: 20),
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
                                  // AnimatedBuilder(
                                  //   animation: controller,
                                  //   builder: (context, child) =>
                                  //       Transform.translate(
                                  //     offset: Offset(
                                  //       0,
                                  //       100 * (1 - animation.value),
                                  //     ),
                                  //     child: child,
                                  //   ),
                                  //   child:
                                  ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: movieModel.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
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
                                          return Get.to(DetailsScreen(
                                              movie: movieDetails));
                                        },
                                        index: index,
                                        // genres: [],
                                        genres: genres,
                                        movieModel: movieModel,
                                      );
                                    },
                                  ),
                                  // ),
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

                                  SizedBox(height: 30),
                                ],
                              ),
                              footer(),
                            ],
                          ),
                        );
                      }
                    })
                : noInternet(),
          )
        ],
      ),
    );
  }
}
