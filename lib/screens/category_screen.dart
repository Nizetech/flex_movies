import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../service/provider/watch_list_provider.dart';
import '../utils/colors.dart';

class CategoryScreen extends ConsumerWidget {
  CategoryScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  // int selected = 1;
  List category = [];
  // double value = 5.0;
  @override
  Widget build(BuildContext context, ref) {
    String genre = ref.watch(genreSelected);
    int page = ref.watch(pageProvider);
    // int value = ref.watch(sliderProvider);
    final value = ref.watch(basicSlider.state).state;

    // int vlaue = ref.watch(sliderProvider) as int;
    // String selected;
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
          // children: [
          //   genres(
          //     genres: firstGen,
          //   ),
          //   const SizedBox(height: 10),
          //   genres(
          //     genres: secondGen,
          //   ),
          //   const SizedBox(height: 10),
          //   genres(
          //     genres: thirdGen,
          //   ),
          //   const SizedBox(height: 10),
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           genre,
          //           style: const TextStyle(
          //               fontStyle: FontStyle.italic,
          //               fontSize: 20,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.white),
          //         ),
          //         InkWell(
          //             onTap: () {
          //               showModalBottomSheet(
          //                 shape: const RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.only(
          //                   topLeft: Radius.circular(20),
          //                   topRight: Radius.circular(20),
          //                 )),
          //                 context: context,
          //                 builder: (context) => const _RatingSlider(),
          //               );
          //             },
          //             radius: 10,
          //             child: const Icon(Icons.filter_list, color: Colors.white)),
          //       ],
          //     ),
          //   ),
          //   const SizedBox(height: 20),
          //   Expanded(
          //     child: FutureBuilder<List<dynamic>>(
          //         future: ApiService.getCategoryList(genre, page, 3),
          //         builder: (context, snapshot) {
          //           if (snapshot.hasData &&
          //               snapshot.data != null &&
          //               snapshot.data!.isNotEmpty) {
          //             category = snapshot.data!;
          //             print(snapshot.data);
          //             return SingleChildScrollView(
          //               child: Column(
          //                 children: [
          //                   ListView.separated(
          //                     scrollDirection: Axis.vertical,
          //                     physics: const NeverScrollableScrollPhysics(),
          //                     shrinkWrap: true,
          //                     itemCount: category.length,
          //                     padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          //                     separatorBuilder:
          //                         (BuildContext context, int index) =>
          //                             const SizedBox(height: 20),
          //                     itemBuilder: (BuildContext context, int index) {
          //                       // print(
          //                       //     'Wachlist genres ==> ${category[index]['genres']}');

          //                       List genres = category[index]['genres'] ?? [];
          //                       return HotMovie(
          //                         onTap: () {
          //                           // print(
          //                           //     'Movie ID ==> ${category[index]['id'].runtimeType}');

          //                           Map movieDetails = {};

          //                           movieDetails.addAll({
          //                             'id': category[index]['id'],
          //                           });
          //                           return Get.to(
          //                               DetailsScreen(movie: movieDetails));
          //                         },
          //                         index: index,
          //                         genres: genres,
          //                         movieModel: category,
          //                       );
          //                       //   },
          //                       // ),
          //                     },
          //                   ),
          //                   const SizedBox(height: 20),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       if (page > 1)
          //                         TextButton(
          //                             style: ButtonStyle(
          //                                 backgroundColor:
          //                                     MaterialStateProperty.all(
          //                                         Colors.red.withOpacity(.8))),
          //                             onPressed: () {
          //                               ref.read(pageProvider.notifier).state--;

          //                               category.clear();
          //                             },
          //                             child: Text(
          //                               'Previous',
          //                               style: TextStyle(
          //                                   fontSize: 16,
          //                                   color: white,
          //                                   fontWeight: FontWeight.bold),
          //                             )),
          //                       const SizedBox(width: 20),
          //                       TextButton(
          //                           style: ButtonStyle(
          //                             backgroundColor: MaterialStateProperty.all(
          //                               mainColor.withOpacity(.8),
          //                             ),
          //                           ),
          //                           onPressed: () {
          //                             category.clear();
          //                             ref
          //                                 .read(pageProvider.notifier)
          //                                 .incrementPage();
          //                           },
          //                           child: Text(
          //                             'Next',
          //                             style: TextStyle(
          //                                 fontSize: 16,
          //                                 color: white,
          //                                 fontWeight: FontWeight.bold),
          //                           )),
          //                     ],
          //                   ),
          //                   const SizedBox(height: 20),
          //                 ],
          //               ),
          //             );
          //           } else {
          //             return const Center(child: CircularProgressIndicator());
          //           }
          //         }),
          //   )
          // ],
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      height: 300,
      child: Column(children: [
        const Text(
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
                ref.read(sliderProvider.notifier).state = val;
                // log('my Value===> $val');
              }),
        ),
        const SizedBox(height: 20),
        TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.red.withOpacity(.8))),
            onPressed: () {
              Get.back();

              // category.clear();
            },
            child: Text(
              'Apply',
              style: TextStyle(
                  fontSize: 16, color: white, fontWeight: FontWeight.bold),
            )),
      ]),
    );
  }
}
