import 'package:flex_movies/screens/details_screen.dart';
import 'package:flex_movies/screens/search/result_page.dart';
import 'package:flex_movies/screens/widgets/widgets.dart';
import 'package:flex_movies/service/api_service.dart';
import 'package:flex_movies/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  // final List movie;
  // final List suggestion;
  SearchScreen({
    Key? key,
    // required this.movie, required this.suggestion
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController search = TextEditingController();
  String searchQuery = '';
  List movieModel = [];

  Map movieDetails = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   leadingWidth: 0,
        //   leading: SizedBox(),
        //   title:

        // ),
        body: SafeArea(
      child: Column(
        children: [
          TextField(
            controller: search,
            autofocus: true,
            cursorColor: Colors.white,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
            onSubmitted: (val) {
              searchQuery = search.text.trim().toLowerCase();
              // Get.to(() => Get.to(SearchResultPage(
              //       searchQuery: searchQuery,
              //     )));
            },
            decoration: InputDecoration(
              hintText: 'Search movies....',
              hintStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder(
              future: ApiService().searchMovie('thor'),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Text(
                    'No Data Found',
                    style: TextStyle(fontSize: 20, color: white),
                  ));
                }
                movieModel = snapshot.data;
                print('Search Result: $movieModel');
                return SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: movieModel.length,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 20),
                        itemBuilder: (BuildContext context, int index) {
                          List<String> genres = movieModel[index].genres;
                          return HotMovie(
                            onTap: () {
                              movieDetails.addAll({
                                'id': movieModel[index].id,
                              });
                              return Get.to(DetailsScreen(movie: movieDetails));
                            },
                            index: index,
                            genres: genres,
                            movieModel: movieModel,
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    ));
  }
}
