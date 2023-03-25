import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../key/api_key.dart';
import '../service/provider/watch_list_provider.dart';
import 'search/search_screen.dart';

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
    int totalWatchlist = ref.watch(favoriteProvider.notifier).totalFavorite;
    List watchlist = ref.watch(favoriteProvider.notifier).favorite;
    print('Wachlist ==> $totalWatchlist');
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
              onPressed: () => Get.to(const SearchScreen()),
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: totalWatchlist == 0
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
              // children: [
              //   Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 20),
              //     child: TextButton(
              //       onPressed: () {
              //         ref.read(favoriteProvider.notifier).clearFavorite();
              //       },
              //       style: TextButton.styleFrom(
              //         backgroundColor: Colors.red,
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 15, vertical: 10),
              //       ),
              //       child: Text(
              //         'Remove All',
              //         style: TextStyle(
              //           fontSize: 14,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              //   const SizedBox(height: 10),
              //   // totalWatchlist == []
              //   //     ? const Center(
              //   //         child: Text(
              //   //           'No Movie in Watchlist',
              //   //           style: TextStyle(
              //   //             fontSize: 20,
              //   //             fontWeight: FontWeight.bold,
              //   //             color: Colors.white,
              //   //           ),
              //   //         ),
              //   //       )
              //   //     :
              //   Expanded(
              //     child: ListView.separated(
              //       scrollDirection: Axis.vertical,
              //       shrinkWrap: true,
              //       itemCount: totalWatchlist,
              //       padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              //       separatorBuilder: (BuildContext context, int index) =>
              //           SizedBox(height: 20),
              //       itemBuilder: (BuildContext context, int index) {
              //         print(
              //             'Wachlist genres ==> ${watchlist[index]['genres']}');

              //         List genres = watchlist[index]['genres'] == null
              //             ? []
              //             : watchlist[index]['genres'];
              //         return HotMovie(
              //           onTap: () {
              //             print(
              //                 'Movie ID ==> ${watchlist[index]['id'].runtimeType}');
              //             //print typedef of totalWatchlist

              //             movieModel = watchlist;
              //             movieDetails.addAll({
              //               'id': watchlist[index]['id'],
              //             });
              //             return Get.to(DetailsScreen(movie: movieDetails));
              //           },
              //           index: index,
              //           isWatchlist: true,
              //           // genres: [],
              //           genres: genres,
              //           movieModel: watchlist,
              //         );
              //       },
              //     ),
              //   ),
              // ],
            ),
    );
  }
}
