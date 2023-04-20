// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_moviez/screens/search/search_screen.dart';
import 'package:flex_moviez/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../key/api_key.dart';
import '../service/provider/watch_list_provider.dart';
import 'movie_details/details_screen.dart';

class WatchList extends ConsumerWidget {
  WatchList({Key? key}) : super(key: key);

  static Box box = Hive.box(kAppName);

  // List totalWatchlist = WatchList.box.get('watchlist');

  List movieModel = [];

  Map movieDetails = {};

  @override
  Widget build(BuildContext context, ref) {
    final watchlist = ref.watch(favoriteProvider);
    log('Wachlist ==> ${totalWatchlist}');

    return Scaffold(
      appBar: AppBar(
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
              onPressed: () => Get.to(SearchScreen()),
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: watchlist.length == 0 || watchlist.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset('assets/no_watchlist.png')),
                SizedBox(height: 20),
                Text(
                  'No Movie in Watchlist!!!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
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
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: watchlist.length,
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
                )
              ],
            ),
    );
  }
}
