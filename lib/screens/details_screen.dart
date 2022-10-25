import 'package:cached_video_player/cached_video_player.dart';
import 'package:flex_movies/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:video_player/video_player.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 50),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/img1.jpg',
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      child: Container(
                        alignment: Alignment.topCenter,
                        height: 400,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(.3),
                              Colors.black.withOpacity(.2),
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black.withOpacity(.94),
                              Colors.black,
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 20,
                      child: Text(
                        'Mimic',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xff212029),
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Watchlist',
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: const [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xff212029),
                            child: Icon(
                              Icons.local_movies_outlined,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Trailer',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: const [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xff212029),
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Watchlist',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            '23-03-19',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height: 15,
                              child: VerticalDivider(
                                color: Colors.white,
                              )),
                          Text(
                            'season 1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                            child: VerticalDivider(
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.watch_later_outlined,
                            color: Colors.white,
                            size: 15,
                          ),
                          SizedBox(width: 5),
                          Text(
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
                          children: const [
                            TextSpan(
                              text: ' Drama, Crime, & Mystery',
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
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Storyline hysysiyfIYzfUYIuzhIOHIHiHPIHpispihspidpiwhsidwpiahihqIHPIHWPIDIHPIHPI Storyline hysysiyfIYzfUYIuzhIOHIHiHPIHpispihspidpiwhsidwpiahihqIHPIHWPIDIHPIHPI Storyline hysysiyfIYzfUYIuzhIOHIHiHPIHpispihspidpiwhsidwpiahihqIHPIHWPIDIHPIHPI Storyline hysysiyfIYzfUYIuzhIOHIHiHPIHpispihspidpiwhsidwpiahihqIHPIHWPIDIHPIHPIStoryline hysysiyfIYzfUYIuzhIOHIHiHPIHpispihspidpiwhsidwpiahihqIHPIHWPIDIHPIHPI  HPIH',
                        maxLines: 4,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Cast',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 90,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 6,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(width: 20),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.amber[800],
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    'assets/profile.jpg',
                                    height: 65,
                                    width: 65,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              const SizedBox(
                                width: 65,
                                child: Text(
                                  'Casie Mero ',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    overflow: TextOverflow.fade,
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
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
                                          : Icons.play_circle_filled_rounded,
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
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Flex Movies',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 130,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 6,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(width: 20),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.asset(
                            'assets/img2.jpg',
                            height: 130,
                            width: 250,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
