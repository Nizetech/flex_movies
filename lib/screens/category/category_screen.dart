import 'dart:developer';
import 'package:flex_movies/screens/category/widget.dart';
import 'package:flex_movies/screens/movie_details/details_screen.dart';
import 'package:flex_movies/screens/widgets/download.dart';
import 'package:flex_movies/screens/widgets/widgets.dart';
import 'package:flex_movies/service/api_service.dart';
import 'package:flex_movies/service/provider/watch_list_provider.dart';
import 'package:flex_movies/utils/colors.dart';
import 'package:flex_movies/utils/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  List category = [];

  @override
  Widget build(
    BuildContext context,
  ) {
    String genre = ref.watch(genreSelected);
    int page = ref.watch(pageProvider);
    final rate = ref.watch(sliderProvider);
    String rating = (rate * 2).toString();
    // DateTime date = DateTime.now();
    String year = ref.watch(yearProvider).toString();

    // final value = ref.watch(sliderProvider);
    print('Year ==> $year');

    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 10,
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
      ),
      body: Column(
        children: [
          genres(
            genres: firstGen,
          ),
          SizedBox(height: 10),
          genres(
            genres: secondGen,
          ),
          SizedBox(height: 10),
          genres(
            genres: thirdGen,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  genre,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                        context: context,
                        builder: ((context) => RatingSlider()),
                      );
                    },
                    radius: 10,
                    child: Icon(Icons.filter_list, color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
                future: ApiService.getCategoryList(genre, page, rating, year),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    category = snapshot.data!;
                    // print(snapshot.data);
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: category.length,
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(height: 20),
                            itemBuilder: (BuildContext context, int index) {
                              List genres = category[index]['genres'] ?? [];
                              return MyAnimatedList(
                                  index: index,
                                  category: category,
                                  genre: genres,
                                  id: category[index]['id']);
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (page > 1)
                                TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red.withOpacity(.8))),
                                    onPressed: () {
                                      ref.read(pageProvider.notifier).state--;

                                      category.clear();
                                    },
                                    child: Text(
                                      'Previous',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: white,
                                          fontWeight: FontWeight.bold),
                                    )),
                              SizedBox(width: 20),
                              TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      mainColor.withOpacity(.8),
                                    ),
                                  ),
                                  onPressed: () {
                                    category.clear();
                                    ref
                                        .read(pageProvider.notifier)
                                        .incrementPage();
                                  },
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    );
                  } else {
                    return FutureBuilder(
                      future: Future.delayed(Duration(seconds: 5)),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return noMovieFound();
                        } else {
                          return loader();
                        }
                      },
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
