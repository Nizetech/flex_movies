import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flex_moviez/botton_nav.dart';
import 'package:flex_moviez/key/api_key.dart';
import 'package:flex_moviez/screens/common/widget.dart';
import 'package:flex_moviez/screens/widgets/download.dart';
import 'package:flex_moviez/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';

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
  // initDynamicLinks();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  // pull to refresh page
  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 2));
    checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flex Moviez',
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
                  child: noInternet(),
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
