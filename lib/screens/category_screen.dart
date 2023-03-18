import 'package:flex_movies/service/provider/watch_list_provider.dart';
import 'package:flex_movies/utils/colors.dart';
import 'package:flex_movies/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryScreen extends ConsumerWidget {
  CategoryScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  int selected = 1;
  // String selected = 'Action';
  @override
  Widget build(BuildContext context, ref) {
    String selected;
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
              String index = genre;
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
                      color: selected == index ? Colors.black : Colors.white,
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
