import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_movies/key/api_key.dart';
import 'package:flex_movies/screens/details_screen.dart';
import 'package:flex_movies/screens/search/search_screen.dart';
import 'package:flex_movies/screens/widgets/widgets.dart';
import 'package:flex_movies/service/api_service.dart';
import 'package:flex_movies/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WatchList extends StatefulWidget {
  WatchList({Key? key}) : super(key: key);

  static Box box = Hive.box(kAppName);

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  List totalWatchlist = WatchList.box.get('watchlist');

  List movieModel = [];

  Map movieDetails = {};

  @override
  Widget build(BuildContext context) {
    //destructure the map
    // watchlist.entries.map((e) => movieModel.add(e.value)).toList();

    print('Wachlist ==> ${totalWatchlist}');
    // print('Movie ==> ${movie.length}');
    // print('Movie ==> ${movie[0]['title']}');

    return Scaffold(
      appBar: AppBar(
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
              onPressed: () => Get.to(SearchScreen()),
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: totalWatchlist == []
          ? const Center(
              child: Text(
                'No Movie in Watchlist',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        totalWatchlist.clear();
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                    ),
                    child: Text(
                      'Remove All',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                totalWatchlist == []
                    ? const Center(
                        child: Text(
                          'No Movie in Watchlist',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: totalWatchlist.length,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: 20),
                          itemBuilder: (BuildContext context, int index) {
                            print(
                                'Wachlist Total ==> ${totalWatchlist[index]['genre']}');

                            List genres = totalWatchlist[index]['genre'] == null
                                ? []
                                : totalWatchlist[index]['genre'];
                            return HotMovie(
                              onTap: () {
                                print(
                                    'Movie ID ==> ${totalWatchlist[index]['id'].runtimeType}');
                                //print typedef of totalWatchlist

                                movieModel = totalWatchlist;
                                movieDetails.addAll({
                                  'id': totalWatchlist[index]['id'],
                                });
                                return Get.to(
                                    DetailsScreen(movie: movieDetails));
                              },
                              index: index,
                              isWatchlist: true,
                              // genres: [],
                              genres: genres,
                              movieModel: totalWatchlist,
                            );
                          },
                        ),
                      ),
              ],
            ),
    );
  }
}
