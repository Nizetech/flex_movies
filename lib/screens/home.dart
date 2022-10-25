import 'package:flex_movies/screens/details_screen.dart';
import 'package:flex_movies/screens/search_screen.dart';
import 'package:flex_movies/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    ApiService.getAllMovieList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      backgroundColor: Colors.black,
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
            child: FutureBuilder(
                // future: ,
                builder: (context, snapshot) {
              return Column(
                children: [
                  // SizedBox(height: 50),
                  GestureDetector(
                    onTap: () => Get.to(DetailsScreen()),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/img1.jpg',
                          height: 350,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        Positioned(
                          child: Container(
                            alignment: Alignment.topCenter,
                            height: 350,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(.6),
                                  Colors.black.withOpacity(.4),
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
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Top Movies',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
                            return GestureDetector(
                              onTap: () => Get.to(DetailsScreen()),
                              child: Image.asset(
                                'assets/img2.jpg',
                                height: 130,
                                width: 130,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 40),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Trending Movies',
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
                              'assets/img1.jpg',
                              height: 130,
                              width: 130,
                              fit: BoxFit.cover,
                            );
                          },
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
              );
            }),
          ),
        ],
      ),
    );
  }
}
