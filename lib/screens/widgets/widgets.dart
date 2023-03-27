import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_movies/key/api_key.dart';
import 'package:flex_movies/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../service/provider/watch_list_provider.dart';
import '../../utils/colors.dart';

Widget castWidget({required List cast, required int index}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CircleAvatar(
        radius: 35,
        backgroundColor: Color(0xff212029),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
            imageUrl: cast[index]['url_small_image'] ??
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEPPiaQhO0spbCu9tuFuG3QsKNOjMuplRr2A&usqp=CAU',
            fit: BoxFit.cover,
            height: 68,
            width: 68,
          ),
        ),
      ),
      SizedBox(height: 5),
      SizedBox(
        width: 65,
        child: Text(
          cast[index]['name'],
          maxLines: 2,
          textAlign: TextAlign.center,
          style: const TextStyle(
            overflow: TextOverflow.fade,
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

class HotMovie extends ConsumerStatefulWidget {
  final List movieModel;
  final int index;
  final List genres;
  final bool? isWatchlist;
  final Function() onTap;
  const HotMovie(
      {Key? key,
      required this.movieModel,
      required this.index,
      required this.onTap,
      this.isWatchlist = false,
      required this.genres})
      : super(key: key);

  @override
  ConsumerState<HotMovie> createState() => _HotMovieState();
}

class _HotMovieState extends ConsumerState<HotMovie> {
  @override
  Widget build(BuildContext context) {
    final watchlist = ref.watch(favoriteProvider);

    log('>>>>> $watchlist');

    // print(' my genre ==>${widget.movieModel[widget.index]['genre']}');
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 150,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor.withOpacity(.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                errorWidget: (context, url, error) => Container(
                  color: Colors.black,
                ),
                // imageUrl: movieModel[index].largeCoverImage,
                imageUrl: widget.movieModel[widget.index]['large_cover_image'],
                height: 130,
                width: 130,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          // movieModel[index].title,
                          widget.movieModel[widget.index]['title'],
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          Map movie = {
                            'id': widget.movieModel[widget.index]['id']
                                .toString(),
                            'title': widget.movieModel[widget.index]['title'],
                            'genres': widget.movieModel[widget.index]['genres'],
                            'large_cover_image': widget.movieModel[widget.index]
                                ['large_cover_image'],
                            'rating': widget.movieModel[widget.index]['rating'],
                            'isFavorite': false,
                          };
                          if (widget.isWatchlist != true) {
                            final toggle = ref
                                .read(favoriteProvider.notifier)
                                .toggleFavorite(
                                  movie,
                                  // movie['isFavorite'],
                                );
                            // if (toggle == WatchListType.added) {
                            //   showToast('Added ${movie['title']} to watchlist');
                            // } else {
                            //   showErrorToast(
                            //       'Removed ${movie['title']} from watchlist');
                            // }

                            // if (isWatchlist) {
                            //   ref
                            //       .read(favoriteProvider.notifier)
                            //       .removeFavorite(movie);
                            //   log('Added ==> ${movie['title']} to watchlist,=====> $movie');
                            //   showErrorToast(
                            //       'Removed ${movie['title']} from watchlist');
                            // } else {
                            //   ref
                            //       .read(favoriteProvider.notifier)
                            //       .addFavorite(movie);
                            //   log('Added ==> ${movie['title']} to watchlist,=====> $movie');
                            //   showToast('Added ${movie['title']} to watchlist');
                            // }

                            // ref.read(favoriteProvider.notifier).isFavorite ==
                            //     true;
                            // print('===> $isWatchlist');
                            // ref
                            //     .read(favoriteProvider.notifier)
                            //     .toggleWatchlist();
                            // if (isFavorite) {
                            //   ref
                            //       .read(favoriteProvider.notifier)
                            //       .addFavorite(movie);
                            //   log('Added ==> $movie to watchlist,=====> $movie');
                            //   showToast('Added to watchlist');
                            // } else {
                            //   ref
                            //       .read(favoriteProvider.notifier)
                            //       .removeFavorite(movie);
                            //   showErrorToast('Removed from Watchlist');
                            // }

                            // log('Added ==> $movie to watchlist,=====> $movie');
                            // showToast('Added to watchlist');
                          } else {
                            ref.read(favoriteProvider.notifier).clearFavorite();
                            showErrorToast('Removed from Watchlist');
                          }
                        },
                        child: Icon(
                          widget.isWatchlist == true
                              ? Icons.delete_rounded
                              // : isFavorite
                              : watchlist.contains(widget
                                      .movieModel[widget.index]['id']
                                      .toString())
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                          color: widget.isWatchlist != true &&
                                  watchlist.contains(widget
                                      .movieModel[widget.index]['id']
                                      .toString())
                              ? Colors.red
                              : mainColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  RatingBarIndicator(
                    rating: widget.movieModel[widget.index]['rating'] == null
                        ? 0
                        : widget.movieModel[widget.index]['rating'].toDouble() /
                            2,
                    itemBuilder: (context, index) => Icon(
                      Icons.star_rate_rounded,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 18,
                    unratedColor: Colors.white.withOpacity(.5),
                    direction: Axis.horizontal,
                  ),
                  Spacer(),
                  Wrap(
                    children: [
                      for (var genre in widget.genres)
                        Text(
                          widget.genres.last == genre ? genre : genre + ' , ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieSuggestions extends StatefulWidget {
  final List movieSuggestion;

  final int index;
  Color? color;

  final Function() onTap;

  MovieSuggestions(
      {Key? key,
      required this.movieSuggestion,
      required this.onTap,
      this.color,
      required this.index})
      : super(key: key);

  @override
  State<MovieSuggestions> createState() => _MovieSuggestionsState();
}

class _MovieSuggestionsState extends State<MovieSuggestions> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: widget.movieSuggestion[widget.index]
                  ['medium_cover_image'],
              fit: BoxFit.cover,
              height: 130,
              filterQuality: FilterQuality.high,
              width: 200,
            ),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: widget.color ?? Color(0xff24243B),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.movieSuggestion[widget.index]['title'],
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: white,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_outlined,
                        color: mainColor,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text(
                        (widget.movieSuggestion[widget.index]['rating'] / 2)
                            .toString(),
                        style: TextStyle(
                          color: white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TopMovie extends StatefulWidget {
  final List movieSuggestion;

  final int index;
  final Color? color;
  final Color? txtColor;

  final Function() onTap;

  TopMovie(
      {Key? key,
      required this.movieSuggestion,
      required this.onTap,
      this.color,
      this.txtColor,
      required this.index})
      : super(key: key);

  @override
  State<TopMovie> createState() => _TopMovieState();
}

class _TopMovieState extends State<TopMovie> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: widget.movieSuggestion[widget.index]
                  ['large_cover_image'],
              fit: BoxFit.fill,
              height: 180,
              width: 200,
              filterQuality: FilterQuality.high,
            ),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: widget.color ?? Color(0xff24243B),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.movieSuggestion[widget.index]['title'],
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: widget.txtColor ?? white,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_outlined,
                        color: mainColor,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text(
                        (widget.movieSuggestion[widget.index]['rating'] /
                                2.toDouble())
                            .toString(),
                        style: TextStyle(
                          color: white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget footer() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
      ),
      color: Colors.white.withOpacity(.3),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Nizetech',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Icon(Icons.copyright_outlined, color: Colors.grey, size: 15),
        Text(
          '  2023',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

dynamic showToast(String label) {
  return Get.snackbar(
    'Success',
    label,
    duration: Duration(seconds: 3),
    backgroundColor: Colors.green,
    colorText: white,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.only(
      bottom: 20,
      right: 20,
      left: 20,
    ),
  );
}

dynamic showErrorToast(String label) {
  return Get.snackbar(
    'Success',
    label,
    duration: Duration(seconds: 3),
    backgroundColor: Colors.red,
    colorText: white,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.only(
      bottom: 20,
      right: 20,
      left: 20,
    ),
  );
}

//  void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontWeight: FontWeight.w300,
//             fontSize: 16.0,
//           ),
//         ),
//         backgroundColor: Colors.green,
//         behavior: SnackBarBehavior.floating,
//         elevation: 1.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(50.0),
//         ),
//       ),
//     );
//   }

// Widget successToast(String message) {
//   return  Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 1,
//     backgroundColor: Colors.green,
//     textColor: Colors.white,
//     fontSize: 16.0,
//   );
// }

class ActionTabs extends StatefulWidget {
  final Map movie;
  final ScrollController? controller;
  bool isHome;
  ActionTabs(
      {Key? key, required this.movie, this.controller, this.isHome = false})
      : super(key: key);

  @override
  State<ActionTabs> createState() => _ActionTabsState();
}

class _ActionTabsState extends State<ActionTabs> {
  Map<String, dynamic> movieDetails = {};
  // static Box box = Hive.box(kAppName);
  // List watchlist = box.get('watchlist', defaultValue: []);
  // List totalWatchlist = box.get('watchlist') ?? [];

  final double _height = 100.0;
  void _animateToIndex(int index) {
    if (widget.isHome == true) {
      movieDetails.addAll({
        'id': widget.movie[index]['id'],
      });
      Get.to(DetailsScreen(
        movie: movieDetails,
      ));
      // ?.then((value) {
      widget.controller!.animateTo(
        index * _height,
        duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
      // });
    } else {
      widget.controller!.animateTo(
        index * _height,
        duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Consumer(builder: (context, ref, child) {
                return GestureDetector(
                  onTap: () {
                    Map movie = {
                      'id': widget.movie['id'].toString(),
                      'title': widget.movie['title'],
                      'large_cover_image': widget.movie['large_cover_image'],
                      'rating': widget.movie['rating'],
                      'isFavorite': true,
                    };
                    // ref.read(favoriteProvider.notifier).addFavorite(movie);
                    // watchlist.add(widget.movie);
                    // box.put('watchlist', watchlist);
                    log('Added ==> $movie to watchlist,=====> $movie');
                    showToast('Added to watchlist');
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xff212029),
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
              SizedBox(height: 10),
              Text(
                'Watchlist',
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              _animateToIndex(8);
            },
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xff212029),
                  child: Icon(
                    Icons.local_movies_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Trailer',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Column(
            children: const [
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xff212029),
                child: Icon(
                  Icons.share,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Share',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
