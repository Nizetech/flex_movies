import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../service/provider/watch_list_provider.dart';
import '../../utils/colors.dart';
import '../movie_details/details_screen.dart';
import '../widgets/widgets.dart';

class MyAnimatedList extends StatefulWidget {
  // final bool? is
  final int id;
  final int index;
  final List genre;
  final List category;

  const MyAnimatedList({
    super.key,
    required this.index,
    required this.category,
    required this.genre,
    required this.id,
  });

  @override
  State<MyAnimatedList> createState() => _MyAnimatedListState();
}

class _MyAnimatedListState extends State<MyAnimatedList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;
  // late  Animation

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // this._controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _controller.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     _controller.forward();
    //   }
    // });
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Transform.translate(
        offset: Offset(
          100 * (1 - animation.value),
          0,
        ),
        child: child,
      ),
      child: HotMovie(
        onTap: () {
          Map movieDetails = {};

          movieDetails.addAll({
            'id': widget.id,
          });
          return Get.to(DetailsScreen(movie: movieDetails));
        },
        index: widget.index,
        genres: widget.genre,
        movieModel: widget.category,
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
                onTap: () {
                  ref.read(genreProvider.notifier).updateGenre(genre);
                },
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
}

class RatingSlider extends ConsumerWidget {
  const RatingSlider();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(sliderProvider);
    String label = value.toString();
    // DateTime date = DateTime.now();
    String year = ref.watch(yearProvider).toString();
    // log('Year++=+> $year');
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

Widget noMovieFound() => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            'assets/category_error.png',
            width: Get.width * .7,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'No Movie Found\n for this Category',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            height: 1.5,
            color: white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
