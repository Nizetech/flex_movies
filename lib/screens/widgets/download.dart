import 'dart:developer';
import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flex_moviez/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../utils/colors.dart';

class MyDownload {
  String flud = "com.delphicoder.flud";

  Future<bool> isFluidInstalled(
      // {
      // required String title,
      // required String url,
      // required BuildContext context,
      // required VoidCallback onTap,
      // }
      ) async {
    bool isInstalled = await DeviceApps.isAppInstalled(flud);
    try {
      if (isInstalled) {
        print('===> Installed');
        // downloadFile(title: title, url: url, context: context, onTap: onTap);
        return true;
      } else {
        print('===> Not installed');
        final url = Uri.parse("market://details?id=$flud");
        final url2 =
            Uri.parse("https://play.google.com/store/apps/details?id=$flud");
        launchUrl(
          url2,
          mode: LaunchMode.externalApplication,
        );

        return false;
        // try {
        // } on PlatformException catch (e) {
        //   launchUrl(url2);
        // }
        //finally {
        //   launch(
        //       "https://play.google.com/store/apps/details?id=" + appPackageName);
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> downloadFile({
    required String title,
    required String url,
    required BuildContext context,
    required VoidCallback onTap,
  }) async {
    try {
      //?
      // final mainDir = (await getExternalStorageDirectories(
      //         type: StorageDirectory.downloads))!
      //     .first;
      
      // get External StorageDirectory
      final directory = await getExternalStorageDirectory();
      String mainDir =
          directory!.path.replaceFirst('/Android/data/com.nizetech.app', " ");
      // directory!.path.replaceFirst('Download/com.nizetech.flex_moviez', "");

      // saving file in Downloads folder  of external storage directory of device
      // final myDir = await Directory("/storage/emulated/0/flex_moviez/Downloads")
      final myDir = await Directory("${mainDir}flex_moviez/Downloads")
          .create(recursive: true);

      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          throw "Error";
        },
      );

      File downloadedFile = await File('${myDir.path}/$title.torrent')
          .writeAsBytes(response.bodyBytes);

      // if download is successful
      if (downloadedFile.existsSync()) {
        showToast('Download Successful');
        log(mainDir.toString());
        log('Downloaded File Path ==> ${downloadedFile.path}');

        //?
        OpenFile.open(downloadedFile.path);

        onTap;
      }

      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      return true;
    } catch (e) {
      Navigator.pop(context);
      showErrorToast("Download Failed");
      return false;
    }
  }
}

Future<void> dialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) => Dialog(
      elevation: 10,
      backgroundColor: Colors.black.withOpacity(.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        // side: BorderSide(color: Colors.red, width: 2),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.black.withOpacity(.2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            loader(color: Colors.green),
            SizedBox(height: 10),
            Text(
              "Downloading File...Please Wait",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget loader({Color? color}) => Center(
      child: LoadingAnimationWidget.threeRotatingDots(
        color: color ?? mainColor,
        size: 100,
      ),
    );
