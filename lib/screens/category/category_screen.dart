import 'dart:developer';
import 'package:flex_movies/screens/category/widget.dart';
import 'package:flex_movies/screens/details_screen.dart';
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

class _CategoryScreenState extends ConsumerState<CategoryScreen>
   {
  bool _isLoading = true;
 
  @override
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
    Future.delayed(const Duration(seconds: 20), () {
      setState(() {
        _isLoading = false;
      });
    });
    // final value = ref.watch(sliderProvider);
    print('Year ==> $year');

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
                        builder: ((context) => const _RatingSlider()),
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
                              // print(
                              //     'Wachlist genres ==> ${category[index]['genres']}');

                              List genres = category[index]['genres'] ?? [];
                              return MyAnimatedList(
                                  index: index,
                                  category: category,
                                  genre: genres,
                                  id: category[index]['id']);
                              // AnimatedBuilder(
                              //   animation: animation,
                              //   builder: (context, child) =>
                              //       Transform.translate(
                              //     offset: Offset(
                              //       0,
                              //       100 * (1 - animation.value),
                              //     ),
                              //     child: child,
                              //   ),
                              //   child: HotMovie(
                              //     onTap: () {
                              //       Map movieDetails = {};

                              //       movieDetails.addAll({
                              //         'id': category[index]['id'],
                              //       });
                              //       return Get.to(
                              //           DetailsScreen(movie: movieDetails));
                              //     },
                              //     index: index,
                              //     genres: genres,
                              //     movieModel: category,
                              //   ),
                              // );
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
                    return Center(
                      child: loader(),
                    )
                        // : const Center(
                        //     child: Text(
                        //       'No Data Found',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 24,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   )
                        ;
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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

class _RatingSlider extends ConsumerWidget {
  const _RatingSlider();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(sliderProvider);
    String label = value.toString();
    // DateTime date = DateTime.now();
    String year = ref.watch(yearProvider).toString();
    log('Year++=+> $year');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      height: 300,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "Rating",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Center(
          child: RatingBar.builder(
            initialRating: value,
            minRating: 0,
            glow: false,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 40,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              ref.read(sliderProvider.notifier).state = rating;
              label = rating.toString();
              // print('My Label ===> ${(rating.floor()).toString()}');
            },
          ),
        ),
        Center(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        SizedBox(height: 10),
        const Text(
          "Year",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              height: 45,
              width: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: mainColor, width: 2),
              ),
              child: Text(
                year,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 20),
            TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 10, vertical: 13)),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.black.withOpacity(.8),
                  ),
                ),
                onPressed: () {
                  Get.dialog(Dialog(
                    child: Consumer(
                      builder: ((context, ref, child) {
                        final date = ref.watch(dateProvider);
                        return Container(
                          height: 300,
                          child: Column(
                            children: [
                              Expanded(
                                child: YearPicker(
                                  firstDate:
                                      DateTime(DateTime.now().year - 100, 1),
                                  lastDate: DateTime(DateTime.now().year, 1),
                                  initialDate: date,
                                  selectedDate: date,
                                  onChanged: (DateTime value) {
                                    print(value);
                                    ref
                                        .read(dateProvider.notifier)
                                        .updateDate(value);
                                    print('Current Date ===>$date');
                                  },
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("Apply"))
                            ],
                          ),
                        );
                      }),
                    ),
                  ));

                  ;
                  // category.clear();
                },
                child: Text(
                  'Change',
                  style: TextStyle(
                      fontSize: 16, color: white, fontWeight: FontWeight.bold),
                )),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.red.withOpacity(.8),
                ),
              ),
              onPressed: () {
                Get.back();

                // category.clear();
              },
              child: Text(
                'Apply',
                style: TextStyle(
                    fontSize: 16, color: white, fontWeight: FontWeight.bold),
              )),
        ),
      ]),
    );
  }
}
