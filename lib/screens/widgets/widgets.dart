import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_movies/key/api_key.dart';
import 'package:flex_movies/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

class HotMovie extends StatelessWidget {
  final List movieModel;
  final int index;
  final List genres;
  final Function() onTap;
  const HotMovie(
      {Key? key,
      required this.movieModel,
      required this.index,
      required this.onTap,
      required this.genres})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                errorWidget: (context, url, error) => const Center(
                  child: Text(
                    'NO IMAGE AVAILABLE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // imageUrl: movieModel[index].largeCoverImage,
                imageUrl:
                    // movieModel[index]['large_cover_image'] == null
                    //     ? 'assets/img1.jpg'
                    //     :
                    movieModel[index]['large_cover_image'],
                height: 130,
                width: 130,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
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

                          movieModel[index]['title'],

                          maxLines: 2,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  RatingBarIndicator(
                    rating: movieModel[index]['rating'].toDouble(),
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
                      for (var genre in genres)
                        Text(
                          genres.last == genre ? genre : genre + ' , ',
                          // 'l',
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
                        widget.movieSuggestion[widget.index]['rating']
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
    ;
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
                        widget.movieSuggestion[widget.index]['rating']
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

class ActionTabs extends StatelessWidget {
  final Map movie;
  ActionTabs({Key? key, required this.movie}) : super(key: key);

  static Box box = Hive.box(kAppName);

  // List<Map> watchlist = box.get('watchlist', defaultValue: []);

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
              GestureDetector(
                onTap: () {
                  // watchlist.add(movie);
                  // box.put('watchlist', watchlist);
                  // print('Added $movie');
                  // showToast('Added to watchlist');
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
