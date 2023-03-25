import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../service/provider/all_movies_provider.dart';
import '../service/provider/top_level_providers.dart';
import '../service/provider/top_movies_provider.dart';
import '../utils/colors.dart';
import 'details_screen.dart';
import 'search/search_screen.dart';
import 'widgets/widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  final int index;
  const HomePage({Key? key, required this.index}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _controller = ScrollController();
  int page = 1;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(topMoviesFetcherControllerProvider.notifier)
          .getTopMovieList(widget.index);
      ref
          .read(allMoviesFetcherControllerProvider.notifier)
          .getAllMovieList(widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final allMovies = ref.watch(allMoviesFetcherControllerProvider);
    final topMovies = ref.watch(topMoviesFetcherControllerProvider);

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
                  onPressed: () => Get.to(const SearchScreen(
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  topMovies.when(
                    loading: () => CircularProgressIndicator(),
                    error: (e, st) => Text('$e'),
                    data: (movies) {
                      if (movies.isEmpty) {
                        return const Center(child: Text('No movies'));
                      }

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              final movie = movies[widget.index];

                              Get.to(
                                DetailsScreen(movie: movie.toMap()),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      movies[widget.index].largeCoverImage,
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
                                      movies[widget.index].title,
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
                            movie: movies[widget.index].toMap(),
                            controller: _controller,
                            isHome: true,
                          ),
                          const SizedBox(height: 30),
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
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 250,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: movies.length,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  separatorBuilder: (_, i) =>
                                      const SizedBox(width: 20),
                                  itemBuilder: (_, i) {
                                    return TopMovie(
                                      onTap: () {
                                        final movie = movies[i];

                                        Get.to(DetailsScreen(
                                          movie: movie.toMap(),
                                        ));
                                      },
                                      color: white,
                                      txtColor: Colors.black,
                                      movieSuggestion: movies,
                                      index: i,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Hot Movies',
                          style: TextStyle(
                            color: mainColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      allMovies.when(
                        loading: () => Column(
                          children: [
                            const Expanded(child: CircularProgressIndicator()),
                          ],
                        ),
                        error: (e, st) => Text('$e'),
                        data: (movies) {
                          if (movies.isEmpty) {
                            return Column(
                              children: [
                                Text('No movies'),
                              ],
                            );
                          }

                          return Column(
                            children: [
                              ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: movies.length,
                                physics: const NeverScrollableScrollPhysics(),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                separatorBuilder: (_, i) =>
                                    const SizedBox(height: 20),
                                itemBuilder: (_, i) {
                                  // final genres = movies[i].genres;

                                  //! Note I'm using ProviderScope here for efficiency,
                                  //! so I won't need to pass a movie to HotMovie
                                  //! widget. Check riverpod documentation for this
                                  return ProviderScope(
                                    overrides: [
                                      currentMovieProvider
                                          .overrideWithValue(movies[i])
                                    ],
                                    child: const HotMovie(),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (page > 1)
                                    TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(Colors
                                                    .red
                                                    .withOpacity(.8))),
                                        onPressed: () {
                                          setState(() => page--);
                                          // movieModel.clear();
                                          // topMovies.clear();

                                          //? this clears the previously fetched top movies
                                          //   ref.invalidate(
                                          //       topMoviesFetcherControllerProvider);
                                        },
                                        child: Text(
                                          'Previous',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  const SizedBox(width: 20),
                                  TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          mainColor.withOpacity(.8),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() => page++);
                                        // movieModel.clear();
                                        // topMovies.clear();
                                        // //? this clears the previously fetched top movies
                                        // ref.invalidate(
                                        //     topMoviesFetcherControllerProvider);
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

                              const SizedBox(height: 20),
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

                              const SizedBox(height: 30),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  footer(),
                ],
              ),
            ),
            // child: FutureBuilder<dynamic>(
            //   future: Future.wait([
            //     // ApiService().getAllMovieListModel(page),
            //     // ApiService.getAllMovieList(index),
            //     // ApiService.getTopMovies(index),
            //     getAllMovies,
            //     getTopMovies,

            //     // cast,
            //   ]),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData ||
            //         snapshot.hasError ||
            //         snapshot.data[1].length == 0) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else {
            //       movieModel = snapshot.data[0];
            //       topMovies = snapshot.data[1];

            //       // print('topMovies===> ${searchMovies}');

            //       movieModel.removeWhere(
            //           // (element) => element.title == 'Mephistopheles');
            //           (element) => element['title'] == 'Mephistopheles');
            //       // movieModel.shuffle();
            //       topMovies.shuffle();
            //       // print('topMovies $movieModel');
            //       return SingleChildScrollView(
            //         child: Column(
            //           children: [
            //             GestureDetector(
            //               onTap: () {
            //                 movieData.addAll({
            //                   'large_cover_image': topMovies[widget.index]
            //                       ['large_cover_image'],
            //                   'title': topMovies[widget.index]['title'],
            //                   'id': topMovies[widget.index]['id'],
            //                   'year': topMovies[widget.index]['year'],
            //                   'rating': topMovies[widget.index]['rating'],
            //                   'genres': topMovies[widget.index]['genres'],
            //                   'summary': topMovies[widget.index]['summary'],
            //                   'trailer': topMovies[widget.index]['trailer'],
            //                   'date_uploaded': topMovies[widget.index]
            //                       ['date_uploaded'],
            //                   'description_full': topMovies[widget.index]
            //                       ['description_full'],
            //                 });
            //                 print(movieData);
            //                 Get.to(DetailsScreen(
            //                   movie: movieData,
            //                   // cast: cast[0],
            //                 ));
            //               },
            //               child: Stack(
            //                 alignment: Alignment.center,
            //                 children: [
            //                   CachedNetworkImage(
            //                     imageUrl: topMovies[widget.index]
            //                         ['large_cover_image'],
            //                     errorWidget: (context, url, error) => Container(
            //                       color: Colors.black,
            //                     ),
            //                     height: 350,
            //                     width: double.infinity,
            //                     fit: BoxFit.fill,
            //                   ),
            //                   Positioned(
            //                     child: Container(
            //                       alignment: Alignment.topCenter,
            //                       height: 350,
            //                       decoration: BoxDecoration(
            //                         gradient: LinearGradient(
            //                           begin: Alignment.topCenter,
            //                           end: Alignment.bottomCenter,
            //                           colors: [
            //                             Colors.black.withOpacity(.6),
            //                             Colors.black.withOpacity(.4),
            //                             Colors.transparent,
            //                             Colors.transparent,
            //                             Colors.black.withOpacity(.94),
            //                             Colors.black,
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   Positioned(
            //                     bottom: 20,
            //                     child: SizedBox(
            //                       width: Get.width * .8,
            //                       child: Text(
            //                         topMovies[widget.index]['title'],
            //                         textAlign: TextAlign.center,
            //                         style: const TextStyle(
            //                           fontStyle: FontStyle.italic,
            //                           fontSize: 24,
            //                           color: Colors.white,
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //             ActionTabs(
            //               movie: {
            //                 'id': topMovies[widget.index]['id'].toString(),
            //                 'title': topMovies[widget.index]['title'],
            //                 'large_cover_image': topMovies[widget.index]
            //                     ['large_cover_image'],
            //                 'rating': topMovies[widget.index]['rating'],
            //                 'genres': topMovies[widget.index]['genres'],
            //                 'isFavorite': true,
            //               },
            //               controller: _controller,
            //               isHome: true,
            //               // movie: {},
            //             ),
            //             const SizedBox(height: 30),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 const Padding(
            //                   padding: EdgeInsets.only(left: 20),
            //                   child: Text(
            //                     'Top Movies',
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 18,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                 ),
            //                 const SizedBox(height: 20),
            //                 SizedBox(
            //                   height: 250,
            //                   child: ListView.separated(
            //                     scrollDirection: Axis.horizontal,
            //                     shrinkWrap: true,
            //                     itemCount: topMovies.length,
            //                     padding:
            //                         const EdgeInsets.symmetric(horizontal: 20),
            //                     separatorBuilder:
            //                         (BuildContext context, int index) =>
            //                             const SizedBox(width: 20),
            //                     itemBuilder: (BuildContext context, int index) {
            //                       return TopMovie(
            //                         onTap: () {
            //                           movieDetails.addAll({
            //                             'id': topMovies[index]['id'],
            //                           });

            //                           Get.to(DetailsScreen(
            //                             movie: movieDetails,
            //                           ));
            //                         },
            //                         color: white,
            //                         txtColor: Colors.black,
            //                         movieSuggestion: topMovies,
            //                         index: index,
            //                       );
            //                     },
            //                   ),
            //                 ),
            //                 const SizedBox(height: 20),
            //                 Padding(
            //                   padding: const EdgeInsets.only(left: 20),
            //                   child: Text(
            //                     'Hot Movies',
            //                     style: TextStyle(
            //                       color: mainColor,
            //                       fontSize: 18,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                 ),
            //                 const SizedBox(height: 20),
            //                 ListView.separated(
            //                   scrollDirection: Axis.vertical,
            //                   shrinkWrap: true,
            //                   itemCount: movieModel.length,
            //                   physics: const NeverScrollableScrollPhysics(),
            //                   padding:
            //                       const EdgeInsets.symmetric(horizontal: 20),
            //                   separatorBuilder:
            //                       (BuildContext context, int index) =>
            //                           const SizedBox(height: 20),
            //                   itemBuilder: (BuildContext context, int index) {
            //                     List genres = movieModel[index]['genres'] ?? [];
            //                     // movieModel[index].genres;

            //                     return HotMovie(
            //                       onTap: () {
            //                         movieDetails.addAll({
            //                           'id': movieModel[index]['id'],
            //                           // 'id': movieModel[index].id,
            //                         });
            //                         return Get.to(
            //                             DetailsScreen(movie: movieDetails));
            //                       },
            //                       index: index,
            //                       // genres: [],
            //                       genres: genres,
            //                       movieModel: movieModel,
            //                     );
            //                   },
            //                 ),
            //                 const SizedBox(height: 20),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     if (page > 1)
            //                       TextButton(
            //                           style: ButtonStyle(
            //                               backgroundColor:
            //                                   MaterialStateProperty.all(
            //                                       Colors.red.withOpacity(.8))),
            //                           onPressed: () {
            //                             page--;
            //                             movieModel.clear();
            //                             topMovies.clear();
            //                             setState(() {});
            //                           },
            //                           child: Text(
            //                             'Previous',
            //                             style: TextStyle(
            //                                 fontSize: 16,
            //                                 color: white,
            //                                 fontWeight: FontWeight.bold),
            //                           )),
            //                     const SizedBox(width: 20),
            //                     TextButton(
            //                         style: ButtonStyle(
            //                           backgroundColor:
            //                               MaterialStateProperty.all(
            //                             mainColor.withOpacity(.8),
            //                           ),
            //                         ),
            //                         onPressed: () {
            //                           page++;
            //                           movieModel.clear();
            //                           topMovies.clear();
            //                           setState(() {});
            //                         },
            //                         child: Text(
            //                           'Next',
            //                           style: TextStyle(
            //                               fontSize: 16,
            //                               color: white,
            //                               fontWeight: FontWeight.bold),
            //                         )),
            //                   ],
            //                 ),

            //                 const SizedBox(height: 20),
            //                 // Padding(
            //                 //   padding: const EdgeInsets.symmetric(
            //                 //       horizontal: 20),
            //                 //   child: Wrap(
            //                 //     runSpacing: 10,
            //                 //     spacing: 20,
            //                 //     children: [
            //                 //       for (var i = 1; i < 50; i++)
            //                 //         GestureDetector(
            //                 //           onTap: () {
            //                 //             page + i;
            //                 //             setState(() {});
            //                 //             print('page No ===> $page');
            //                 //           },
            //                 //           child: Text(
            //                 //             i.toString() + '  ',
            //                 //             style: TextStyle(
            //                 //               decoration: page == i
            //                 //                   ? TextDecoration.underline
            //                 //                   : TextDecoration.none,
            //                 //               decorationThickness: 3,
            //                 //               decorationColor:
            //                 //                   page == i ? mainColor : white,
            //                 //               decorationStyle:
            //                 //                   TextDecorationStyle.solid,
            //                 //               fontSize: 14,
            //                 //               color: white,
            //                 //               fontWeight: FontWeight.bold,
            //                 //             ),
            //                 //           ),
            //                 //         ),
            //                 //     ],
            //                 //   ),
            //                 // ),

            //                 const SizedBox(height: 30),
            //               ],
            //             ),
            //             footer(),
            //           ],
            //         ),
            //       );
            //     }
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
