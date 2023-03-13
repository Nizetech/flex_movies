import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flex_movies/model/movie.dart';
import 'package:flex_movies/screens/search/search_screen.dart';
import 'package:flex_movies/screens/widgets/widgets.dart';
import 'package:flex_movies/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:video_player/video_player.dart';

import '../service/api_service.dart';

class DetailsScreen extends StatefulWidget {
  final Map movie;
  // final List cast;
  const DetailsScreen({
    Key? key,
    required this.movie,
    // required this.cast,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isPlay = false;

  late CachedVideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    // controller.play();
    controller = CachedVideoPlayerController.asset(
      'assets/video.mp4',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((_) {
        controller.setVolume(1);
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // List<Cast>? cast = [];
  Map movieDetail = {};
  List cast = [];
  List movieSuggestion = [];
  Map movieId = {};
  int select = 0;

// final split = widget
  @override
  Widget build(BuildContext context) {
    log('my movie ==${widget.movie}');
    // log('my movie ==${widget.cast}');
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            scrolledUnderElevation: 0,
            stretchTriggerOffset: 10,
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
            // expandedHeight: 500,
            elevation: 0,
            // pinned: true,
            floating: true,
            snap: true,

            flexibleSpace: const FlexibleSpaceBar(
              expandedTitleScale: 1.1,
              titlePadding: EdgeInsets.zero,
              // title: Text(
              //   'HOme',
              // ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: FutureBuilder<dynamic>(
                future: Future.wait([
                  ApiService.getMovieSuggestion(widget.movie['id']),
                  ApiService.getMovieDetails(widget.movie['id'].toString()),
                ]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    movieSuggestion = snapshot.data[0];
                    movieDetail = snapshot.data[1];
                    if (movieDetail['cast'] != null) {
                      cast = movieDetail['cast'];
                    } else {
                      cast = [];
                    }
                    print('My Cast length==> ${cast}');
                    // print('My Cast length==> ${movieDetail.length}');
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          // fit: StackFit.loose,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20),
                              ),
                              child: SizedBox(
                                child: CachedNetworkImage(
                                  imageUrl: movieDetail['large_cover_image'],
                                  width: MediaQuery.of(context).size.width,
                                  height: 400,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 60),
                                      child: Text(
                                        'NO IMAGE AVAILABLE',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // top: 30,
                              // bottom: 0,
                              child: Container(
                                alignment: Alignment.topCenter,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.black.withOpacity(.8),
                                      Colors.black,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Text(
                            movieDetail['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ActionTabs(
                          movie: movieDetail,
                          // movie: {},
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    movieDetail['date_uploaded']
                                        .split(' ')[0]
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                    child: VerticalDivider(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.watch_later_outlined,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  const Text(
                                    '2hrs, 34mins',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              RichText(
                                text: TextSpan(
                                  text: 'Genre: ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[200],
                                  ),
                                  children: [
                                    // Use i loop to display the genres

                                    for (var i = 0;
                                        i < movieDetail['genres'].length;
                                        i++,)
                                      TextSpan(
                                        text: movieDetail['genres'][i] + ' , ',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              RichText(
                                text: TextSpan(
                                  text: 'Audio: ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[200],
                                  ),
                                  children: const [
                                    TextSpan(
                                      text: ' English',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              RichText(
                                text: TextSpan(
                                  text: 'Subtitle: ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[200],
                                  ),
                                  children: const [
                                    TextSpan(
                                      text: ' English',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12),
                              const Text(
                                'Storyline:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                movieDetail['description_full'] == ''
                                    ? movieDetail['description_intro']
                                    : movieDetail['description_full'],
                                maxLines: 4,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        cast.isEmpty
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Cast',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    height: 105,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: cast.length,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              SizedBox(width: 20),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return castWidget(
                                            cast: cast, index: index);
                                        //   ],
                                        // ),
                                      },
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Trailer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: AspectRatio(
                                aspectRatio: 16 / 10,
                                child: Stack(
                                  children: <Widget>[
                                    CachedVideoPlayer(controller),
                                    Align(
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        onPressed: () {
                                          if (isPlay) {
                                            setState(() {
                                              controller.pause();
                                              isPlay = false;
                                            });
                                          } else {
                                            // videoPlayerController.play();
                                            setState(() {
                                              isPlay = true;
                                              controller.play();
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          isPlay
                                              ? Icons.pause_circle
                                              : Icons
                                                  .play_circle_filled_rounded,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
                            child: GestureDetector(
                              onTap: () => Get.dialog(
                                Dialog(
                                  backgroundColor: Color(0xFF3237C7),
                                  insetPadding:
                                      EdgeInsets.symmetric(horizontal: 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: StatefulBuilder(
                                        builder: (context, setState) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Radio(
                                                  value: 0,
                                                  groupValue: select,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      value = select;
                                                    });
                                                  }),
                                              Text('data'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                  value: 1,
                                                  groupValue: select,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      value = select;
                                                    });
                                                  }),
                                              Text('data'),
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: mainColor.withOpacity(.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Download',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: white),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.file_download_outlined,
                                      color: white,
                                      size: 25,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'More Movies...',
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 180,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: movieSuggestion.length,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(width: 20),
                            itemBuilder: (BuildContext context, int index) {
                              return MovieSuggestions(
                                onTap: () {
                                  Get.back();
                                  movieId.addAll(
                                      {'id': movieSuggestion[index]['id']});
                                  Get.to(
                                    () => DetailsScreen(movie: movieId),
                                  );
                                  setState(() {});
                                },
                                index: index,
                                movieSuggestion: movieSuggestion,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        footer(),
                      ],
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
