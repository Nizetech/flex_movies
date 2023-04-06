import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:dio/dio.dart';
import 'package:flex_movies/model/movie.dart';
import 'package:flex_movies/screens/search/search_screen.dart';
import 'package:flex_movies/screens/widgets/widgets.dart';
import 'package:flex_movies/screens/youtube_test.dart';
import 'package:flex_movies/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import '../service/api_service.dart';
import '../utils/utils.dart';

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
  // bool isPlay = false;

  // late CachedVideoPlayerController controller;
  // @override
  // void initState() {
  //   super.initState();
  //   // controller.play();
  //   controller = CachedVideoPlayerController.asset(
  //     'assets/video.mp4',
  //     videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
  //   )..initialize().then((_) {
  //       controller.setVolume(1);
  //       setState(() {});
  //     });
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  Map movieDetail = {};
  List cast = [];
  List movieSuggestion = [];
  Map movieId = {};
  int select = 0;

  bool isShowMore = false;

  final imgUrl =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";
  bool downloading = false;
  var progressString = "";

  // @override
  // void initState() {
  //   super.initState();

  //   downloadFile();
  // }

  // FocusNode isMe = FocusNode();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Future<
    void downloadFile() async {
      // Dio dio = Dio();

      try {
        var dir = await getApplicationDocumentsDirectory();
        // print("path ${dir.path}");
        // await dio.download(imgUrl, "${dir.path}/demo.mp4",
        //     onReceiveProgress: (rec, total) {
        //   print("Rec: $rec , Total: $total");

        //   setState(() {
        //     downloading = true;
        //     progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        //   });
        // });
        final directory = await getExternalStorageDirectory();
        // String mainDir = directory.path
        //     .replaceFirst('Android/data/com.julitech.jmovies/files', "");
        // final myDir = await Directory("$mainDir" + "JMovies/Downloads")
        //     .create(recursive: true);

        // final response = await http.get(url).timeout(
        //   Duration(seconds: 20),
        //   onTimeout: () {
        //     throw "Error";
        //   },
        // );

        // File downloadedFile = await File(myDir.path + '/$title.torrent')
        //     .writeAsBytes(response.bodyBytes);
      } catch (e) {
        print(e);
      }

      setState(() {
        downloading = false;
        progressString = "Completed";
      });
      print("Download completed");
    }

    // String duration = getDuration(movieDetail['runtime']);

    // log('my movie ==${widget.movie}');
    // log('my movie ==${widget.cast}');
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
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
                  ApiService.getMovieSuggestion(widget.movie['id'].toString()),
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
                    // print('My Cast length==> ${cast}');
                    print('My Cast length==> ${(movieDetail['runtime'])}');
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
                                      Container(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
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
                          movie: {
                            'id': movieDetail['id'].toString(),
                            'title': movieDetail['title'],
                            'large_cover_image':
                                movieDetail['large_cover_image'],
                            'rating': movieDetail['rating'],
                            'genres': movieDetail['genres'],
                          },
                          controller: _controller,
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
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    movieDetail['year'].toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
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
                                  Text(
                                    MyLogic.getDuration(movieDetail['runtime']),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.star_outlined,
                                    color: mainColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    (movieDetail['rating'] / 2).toString(),
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              RichText(
                                text: TextSpan(
                                  text: 'Genre: ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[200],
                                  ),
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    // Use i loop to display the genres
                                    for (var i = 0;
                                        i < movieDetail['genres'].length;
                                        i++,)
                                      TextSpan(
                                        text: movieDetail['genres'][i] + ' , ',
                                        // text: 'kk',
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
                              GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).requestFocus();
                                  // FocusScope.of(context)
                                },
                                child: Text(
                                  'Storyline',
                                  style: TextStyle(
                                    color: mainColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                movieDetail['description_full'] == ''
                                    ? movieDetail['description_intro']
                                    : movieDetail['description_full'],
                                maxLines: isShowMore ? 20 : 4,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isShowMore = !isShowMore;
                                  });
                                },
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    isShowMore ? 'show  less' : 'show more',
                                    style: TextStyle(
                                      color: mainColor,
                                      height: 1.5,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
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
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Cast',
                                      style: TextStyle(
                                        color: mainColor,
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
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Trailer',
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                            height: 200,
                            child: TrailerWidget(
                              trailerCode: movieDetail['yt_trailer_code'],
                            )),
                        SizedBox(height: 40),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
                            child: GestureDetector(
                              onTap: () {
                                downloadFile();
                                Get.dialog(
                                  Dialog(
                                    backgroundColor: Colors.white,
                                    insetPadding:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: StatefulBuilder(
                                        builder: (context, setState) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                              width: 30,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            Text(
                                                'Downloading ... $progressString'),
                                          ],
                                        ),
                                      );
                                      // Container(
                                      //   padding: const EdgeInsets.all(20),
                                      //   decoration: BoxDecoration(
                                      //       borderRadius:
                                      //           BorderRadius.circular(20),
                                      //       color: Colors.white,
                                      //       border: Border.all(
                                      //         color: mainColor,
                                      //         width: 3,
                                      //       )),
                                      //   child: Column(
                                      //     mainAxisSize: MainAxisSize.min,
                                      //     children: [
                                      //       Row(
                                      //         children: [
                                      //           Radio(
                                      //               value: select,
                                      //               groupValue: 0,
                                      //               onChanged: (value) {
                                      //                 setState(() {
                                      //                   value = select;
                                      //                 });
                                      //               }),
                                      //           Text('data'),
                                      //         ],
                                      //       ),
                                      //       Row(
                                      //         children: [
                                      //           Radio(
                                      //               value: select,
                                      //               groupValue: 1,
                                      //               onChanged: (value) {
                                      //                 setState(() {
                                      //                   value = select;
                                      //                 });
                                      //               }),
                                      //           Text('data'),
                                      //         ],
                                      //       ),
                                      //     ],
                                      //   ),
                                      // );
                                    }),
                                  ),
                                );
                              },
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
                            'Suggestions...',
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
                        const SizedBox(height: 30),
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
