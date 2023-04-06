// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_movies/key/api_key.dart';
import 'package:flex_movies/screens/details_screen.dart';
import 'package:flex_movies/screens/search/search_screen.dart';
import 'package:flex_movies/screens/widgets/widgets.dart';
import 'package:flex_movies/service/api_service.dart';
import 'package:flex_movies/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../service/provider/watch_list_provider.dart';

class WatchList extends ConsumerWidget {
  WatchList({Key? key}) : super(key: key);

  static Box box = Hive.box(kAppName);

  // List totalWatchlist = WatchList.box.get('watchlist');

  List movieModel = [];

  Map movieDetails = {};

  @override
  Widget build(BuildContext context, ref) {
    //destructure the map
    // watchlist.entries.map((e) => movieModel.add(e.value)).toList();
    final totalWatchlist = ref.watch(favoriteProvider.notifier).totalFavorite;
    final watchlist = ref.watch(favoriteProvider.notifier).favorite;
    log('Wachlist ==> ${totalWatchlist}');

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
      body: totalWatchlist == 0 || watchlist.isEmpty
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
                      ref.read(favoriteProvider.notifier).clearFavorite();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                    ),
                    child: const Text(
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
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: totalWatchlist,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 20),
                    itemBuilder: (BuildContext context, int index) {
                      // ignore: avoid_print
                      // print(
                      //     'Wachlist genres ==> ${watchlist[index]['genres']}');

                      List genres = watchlist[index]['genres'] ?? [];
                      return HotMovie(
                        onTap: () {
                          print(
                              'Movie ID ==> ${watchlist[index]['id'].runtimeType}');
                          //print typedef of totalWatchlist

                          movieModel = watchlist;
                          movieDetails.addAll({
                            'id': watchlist[index]['id'],
                          });
                          return Get.to(DetailsScreen(movie: movieDetails));
                        },
                        index: index,
                        isWatchlist: true,
                        // genres: [],
                        genres: genres,
                        movieModel: watchlist,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
