import 'package:flex_movies/screens/movie_details/details_screen.dart';
import 'package:flex_movies/screens/search/search_screen.dart';
import 'package:flex_movies/screens/widgets/widgets.dart';
import 'package:flex_movies/service/api_service.dart';
import 'package:flex_movies/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultPage extends StatefulWidget {
  final String searchQuery;

  SearchResultPage({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  List movieModel = [];

  Map movieDetails = {};

  @override
  Widget build(BuildContext context) {
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
      // body: StreamBuilder(
      //     stream: ApiService().searchMovie(widget.searchQuery),
      //     builder: (context, AsyncSnapshot snapshot) {
      //       if (!snapshot.hasData) {
      //         return Center(
      //             child: Text(
      //           'No Data Found',
      //           style: TextStyle(fontSize: 20, color: white),
      //         ));
      //       }
      //       movieModel = snapshot.data;
      //       return SafeArea(
      //         child: Column(
      //           children: [
      //             SizedBox(height: 10),
      //             ListView.separated(
      //               scrollDirection: Axis.vertical,
      //               shrinkWrap: true,
      //               itemCount: movieModel.length,
      //               physics: NeverScrollableScrollPhysics(),
      //               padding: EdgeInsets.symmetric(horizontal: 20),
      //               separatorBuilder: (BuildContext context, int index) =>
      //                   SizedBox(height: 20),
      //               itemBuilder: (BuildContext context, int index) {
      //                 List<String> genres = movieModel[index].genres;
      //                 return HotMovie(
      //                   onTap: () {
      //                     movieDetails.addAll({
      //                       'id': movieModel[index].id,
      //                     });
      //                     return Get.to(DetailsScreen(movie: movieDetails));
      //                   },
      //                   index: index,
      //                   genres: genres,
      //                   movieModel: movieModel,
      //                 );
      //               },
      //             ),
      //           ],
      //         ),
      //       );
      //     }),
    );
  }
}
