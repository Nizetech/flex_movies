import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../botton_nav.dart';

Widget noInternet() => StatefulBuilder(builder: (context, setState) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/connection.png',
              height: 120,
              width: 100,
            ),
            const Text(
              'No internet connection',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                setState(() {});
                Get.to(BottomNav());
              },
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'Retry',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );
    });

class InternetError extends StatefulWidget {
  const InternetError({super.key});

  @override
  State<InternetError> createState() => _InternetErrorState();
}

class _InternetErrorState extends State<InternetError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/connection.png',
                height: 120,
                width: 100,
              ),
            ),
            const Text(
              'No internet connection',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                setState(() {});
                Get.to(BottomNav());
              },
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'Retry',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
