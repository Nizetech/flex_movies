import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flex_movies/botton_nav.dart';
import 'package:flex_movies/firebase_options.dart';
import 'package:flex_movies/key/api_key.dart';
import 'package:flex_movies/screens/widgets/download.dart';
import 'package:flex_movies/screens/youtube_test.dart';
import 'package:flex_movies/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.blueAccent,
    ),
  );
  SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  await Hive.initFlutter();
  await Hive.openBox(kAppName);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  // Check internet connection
  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  // pull to refresh page
  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 2));
    checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flex Show',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          radioTheme: RadioThemeData(
            overlayColor: MaterialStateProperty.all(Colors.white),
          ),
          fontFamily: 'Raleway',
          dividerColor: Colors.grey,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
          )),
      home: FutureBuilder(
        future: checkInternet(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return BottomNav();
              // return MyHomePage();
            } else {
              return Scaffold(
                body: RefreshIndicator(
                  onRefresh: refresh,
                  child: const Center(
                    child: Text(
                      'No internet connection',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            }
          } else {
            return Scaffold(
              body: Center(
                child: loader(),
              ),
            );
          }
        },
      ),
      // BottomNav(),
    );
  }
}
