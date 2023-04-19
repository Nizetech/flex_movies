import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flex_movies/screens/movie_details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> initDynamicLinks({required BuildContext context}) async {
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    // ignore: unrelated_type_equality_checks
    if (dynamicLinkData.link.path != Uri.parse('uri')) {
      Navigator.pushNamed(context, dynamicLinkData.link.path);
    }
    // onDone navigate to the page
  }, onDone: () async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    Uri deepLink = data!.link;
    try {
      if (deepLink != null) {
        var movieId = deepLink.queryParameters['movieid'];
        Map movieData = {
          'id': movieId,
        };
        if (movieId != null) {
          Get.to(DetailsScreen(
            movie: movieData,
          ));
        }
      } else {
        print("No Link Received");
      }
    } catch (e) {
      print(e.toString());
    }
  }).onError((error) {
    // Handle errors
    print(error.toString());
  });
  // Get any initial links
  final PendingDynamicLinkData? data =
      await FirebaseDynamicLinks.instance.getInitialLink();
  Uri movieLink = data!.link;

  try {
    if (movieLink != null) {
      var movieId = movieLink.queryParameters['movieid'];
      // print('Movie id ==> ${movieId.toString()}');

      Map movieData = {
        'id': movieId,
      };
      if (movieId != null) {
        Get.to(DetailsScreen(
          movie: movieData,
        ));
      }
    } else {
      print("No Link Received");
    }
  } catch (e) {
    print(e.toString());
  }
}
