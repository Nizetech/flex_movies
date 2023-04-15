import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../movie_details/details_screen.dart';
import '../widgets/widgets.dart';

class MyAnimatedList extends StatefulWidget {
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
      duration: const Duration(seconds: 5),
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
