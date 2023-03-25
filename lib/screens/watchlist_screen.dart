import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../service/provider/movies_watchlist_provider.dart';
import '../service/provider/top_level_providers.dart';
import 'search/search_screen.dart';
import 'widgets/widgets.dart';

class WatchList extends ConsumerWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final watchListController = ref.watch(watchListControllerProvider);

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
      body: watchListController.isEmpty
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
                    onPressed: ref
                        .read(watchListControllerProvider.notifier)
                        .deleteAll,
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
                // totalWatchlist == []
                //     ? const Center(
                //         child: Text(
                //           'No Movie in Watchlist',
                //           style: TextStyle(
                //             fontSize: 20,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.white,
                //           ),
                //         ),
                //       )
                //     :
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: watchListController.length,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 20),
                    itemBuilder: (_, i) {
                      return ProviderScope(
                        overrides: [
                          currentMovieProvider
                              .overrideWithValue(watchListController[i])
                        ],
                        child: const HotMovie(isWatchList: true),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
