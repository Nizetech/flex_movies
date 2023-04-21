import 'package:flex_moviez/screens/widgets/widgets.dart';
import 'package:flex_moviez/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/utils.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: Get.height * .2),
                  Center(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Flex Moviez',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 40),
                  moreItem(
                    icon: IconlyLight.chat,
                    text: 'Contact Us',
                    onTap: () => launchUrl(
                      Uri.parse('https://wa.link/yrzsdw'),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                  SizedBox(height: 20),
                  moreItem(
                    icon: Icons.share,
                    text: 'Share App',
                    onTap: () async {
                      Share.share('Hey!!'
                          '\nDownload FlexMovies,the best movie app ever'
                          '\nAn app for downloading high quality movies for free.'
                          '\nGet Flex Moviez From PlayStore now ${MyLogic.appUrl}');
                    },
                  ),
                ],
              ),
            ),
            Spacer(),
            footer(),
          ],
        ),
      ),
    );
  }
}

Widget moreItem(
        {required String text,
        required VoidCallback onTap,
        required IconData icon}) =>
    InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      splashColor: mainColor.withOpacity(.3),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: mainColor, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
