import 'dart:developer';

import 'package:flex_movies/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';

class BottomNav extends ConsumerStatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {
  // static Box box = Hive.box('name');
  // bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);
  int index = 0;
  int currentIndex = 0;
  List<Widget> body = [
    HomePage(),
    Container(),
    Container(),
    Container(),
  ];
  // final fcm = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: index,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
        onTap: (int selectedPage) {
          setState(() => index = selectedPage);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home_1), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Iconsax.category,
              ),
              label: 'Category'),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.heart),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
