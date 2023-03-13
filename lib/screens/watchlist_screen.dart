import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_movies/key/api_key.dart';
import 'package:flex_movies/screens/details_screen.dart';
import 'package:flex_movies/screens/search/search_screen.dart';
import 'package:flex_movies/screens/widgets/widgets.dart';
import 'package:flex_movies/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WatchList extends StatelessWidget {
  WatchList({Key? key}) : super(key: key);

  static Box box = Hive.box(kAppName);

  // List<Map> watchlist = box.get('watchlist', defaultValue: []);
  Map movieDetails = {};
  List movie = [];
  @override
  Widget build(BuildContext context) {
    // movie = watchlist.map((key, value) =>  ).toList();
    // movie.add(watchlist);

    // movie = watchlist.map((key, value) => MapEntry(key, value)).toList();

    //destructure the map
    // movie = watchlist.entries.map((e) => e.value).toList();

    // print('Wachlist ==> ${watchlist}');
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
      body: ListView(children: [
        SizedBox(height: 10),
        // ListView.separated(
        //   scrollDirection: Axis.vertical,
        //   shrinkWrap: true,
        //   itemCount: movie.length,
        //   physics: NeverScrollableScrollPhysics(),
        //   padding: EdgeInsets.symmetric(horizontal: 20),
        //   separatorBuilder: (BuildContext context, int index) =>
        //       SizedBox(height: 20),
        //   itemBuilder: (BuildContext context, int index) {
        //     // List<String> genres = watchlist[index]['genres'];
        //     // List movieMOdel = watchlist[index]
        //     return GestureDetector(
        //       onTap: () {},
        //       child: Container(
        //         height: 150,
        //         width: double.infinity,
        //         padding: EdgeInsets.all(10),
        //         decoration: BoxDecoration(
        //           color: bgColor.withOpacity(.8),
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             // ClipRRect(
        //             //   borderRadius: BorderRadius.circular(10),
        //             //   child: CachedNetworkImage(
        //             //     errorWidget: (context, url, error) => const Center(
        //             //       child: Text(
        //             //         'NO IMAGE AVAILABLE',
        //             //         textAlign: TextAlign.center,
        //             //         style: TextStyle(
        //             //             color: Colors.white,
        //             //             fontSize: 20,
        //             //             fontWeight: FontWeight.bold),
        //             //       ),
        //             //     ),
        //             //     imageUrl: movie[index]['largeCoverImage'],
        //             //     height: 130,
        //             //     width: 130,
        //             //     fit: BoxFit.fill,
        //             //   ),
        //             // ),
        //             SizedBox(width: 10),
        //             Expanded(
        //               child: Column(
        //                 // mainAxisSize: MainAxisSize.min,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   SizedBox(height: 10),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Expanded(
        //                         child: Text(
        //                           movie[index]['title'],
        //                           maxLines: 2,
        //                           textAlign: TextAlign.start,
        //                           style: TextStyle(
        //                             overflow: TextOverflow.ellipsis,
        //                             color: Colors.white,
        //                             fontSize: 20,
        //                             fontWeight: FontWeight.w700,
        //                           ),
        //                         ),
        //                       ),
        //                       SizedBox(width: 20),
        //                       Icon(
        //                         Icons.favorite_rounded,
        //                         color: Colors.red,
        //                       ),
        //                     ],
        //                   ),
        //                   // SizedBox(height: 10),
        //                   // RatingBarIndicator(
        //                   //   rating: watchlist[index]['rating'].toDouble(),
        //                   //   itemBuilder: (context, index) => Icon(
        //                   //     Icons.star_rate_rounded,
        //                   //     color: Colors.amber,
        //                   //   ),
        //                   //   itemCount: 5,
        //                   //   itemSize: 18,
        //                   //   unratedColor: Colors.white.withOpacity(.5),
        //                   //   direction: Axis.horizontal,
        //                   // ),
        //                   // Spacer(),
        //                   // Wrap(
        //                   //   children: [
        //                   //     for (var genre in genres)
        //                   //       Text(
        //                   //         genre + ' , ',
        //                   //         textAlign: TextAlign.start,
        //                   //         style: TextStyle(
        //                   //           color: Colors.white,
        //                   //           fontSize: 14,
        //                   //           fontWeight: FontWeight.w600,
        //                   //         ),
        //                   //       ),
        //                   //   ],
        //                   // )
        //                 ],
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     );
        //     ;
        //   },
        // ),
      ]),
    );
  }
}
