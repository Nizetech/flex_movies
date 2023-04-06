import 'dart:developer';

import 'package:flex_movies/screens/details_screen.dart';
import 'package:flex_movies/screens/widgets/widgets.dart';
import 'package:flex_movies/service/api_service.dart';
import 'package:flex_movies/service/provider/watch_list_provider.dart';
import 'package:flex_movies/utils/colors.dart';
import 'package:flex_movies/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class CategoryScreen extends ConsumerWidget {
  CategoryScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  // int selected = 1;
  List category = [];

  DateTime date = DateTime.now();

  // current year
  int year = DateTime.now().year;
// 1992 to current year
  List years = List.generate(30, (index) => 1992 + index).reversed.toList();

  // double value = 5.0;
  @override
  Widget build(BuildContext context, ref) {
    String genre = ref.watch(genreSelected);
    int page = ref.watch(pageProvider);
    final value = ref.watch(sliderProvider);
    // final value = ref.watch(sliderValue);

    // int vlaue = ref.watch(sliderProvider) as int;
    // String selected;
    log('Years ==> $years');

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
                        builder: (context) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          height: 200,
                          child: Column(children: [
                            Text(
                              "Rating",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Slider(
                                  value: value,
                                  min: 0,
                                  max: 10.0,
                                  label: value.toString(),
                                  activeColor: mainColor,
                                  onChanged: (val) {
                                    // int value = val.round();
                                    // ref
                                    //     .watch(sliderProvider.notifier)
                                    //     .updateSlider(val);

                                    ref.read(sliderProvider.notifier).state =
                                        val;

                                    // value = val;
                                    // ref.read(basicSlider.notifier).state = val;
                                    log('my Value===> $val');
                                  }),
                            ),
                            SizedBox(height: 20),
                            TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.red.withOpacity(.8))),
                                onPressed: () {
                                  Get.back();

                                  // category.clear();
                                },
                                child: Text(
                                  'Apply',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ]),
                        ),
                      );
                    },
                    radius: 10,
                    child: Icon(Icons.filter_list, color: Colors.white)),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
                future: ApiService.getCategoryList(genre, page, 3),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    category = snapshot.data!;
                    print(snapshot.data);
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: category.length,
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(height: 20),
                            itemBuilder: (BuildContext context, int index) {
                              // print(
                              //     'Wachlist genres ==> ${category[index]['genres']}');

                              List genres = category[index]['genres'] == null
                                  ? []
                                  : category[index]['genres'];
                              return HotMovie(
                                onTap: () {
                                  // print(
                                  //     'Movie ID ==> ${category[index]['id'].runtimeType}');

                                  Map movieDetails = {};

                                  movieDetails.addAll({
                                    'id': category[index]['id'],
                                  });
                                  return Get.to(
                                      DetailsScreen(movie: movieDetails));
                                },
                                index: index,
                                genres: genres,
                                movieModel: category,
                              );
                              //   },
                              // ),
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
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          )
        ],
      ),
    );
  }
}

Widget genres({
  required List genres,
}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Consumer(builder: (context, ref, _) {
      return Row(
        children: [
          ...genres.map(
            (genre) {
              // int index = genres.indexOf(genre);
              final selected = ref.watch(genreSelected) == genre;
              // String index = genre;
              return GestureDetector(
                onTap: () =>
                    ref.read(genreProvider.notifier).updateGenre(genre),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: EdgeInsets.only(
                    right: genres.last == genre ? 20 : 10,
                    left: genres.first == genre ? 20 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? mainColor : mainColor.withOpacity(.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: mainColor),
                  ),
                  child: Text(
                    genre,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: selected ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ],
      );
    }),
  );
  // });
}
