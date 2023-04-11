import 'dart:developer';
import 'dart:io';

import 'package:flex_movies/screens/widgets/widgets.dart';
import 'package:flex_movies/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class MyDownload {
  //   try {
  //     // Get the temporary directory of the device.
  //     final directory = await getTemporaryDirectory();

  //     // Create a new file in the temporary directory.
  //     final file = File('${directory.path}/$fileName');

  //     // Download the file from the URL using the HttpClient.
  //     final client = HttpClient();
  //     final request = await client.getUrl(Uri.parse(fileUrl));
  //     final response = await request.close();

  //     // Write the downloaded bytes to the file.
  //     await response.pipe(file.openWrite());

  //     // Move the file from the temporary directory to the internal storage.
  //     final appDirectory = await getApplicationDocumentsDirectory();
  //     await file.rename('${appDirectory.path}/$fileName');
  //   } catch (e) {
  //     print('Error while downloading file: $e');
  //   }

  static void openFileChannel(String filePath) async {
    try {
      var platform = MethodChannel("opentorrent");
      await platform.invokeMethod("openTorrentFile", {"path": filePath});
    } on PlatformException catch (error) {
      print(error);
      showToast("An error occurred");
    }
  }

  static Future<bool> downloadFile({
    required String title,
    required String url,
    required BuildContext context,
    required VoidCallback onTap,
  }) async {
    try {
      // get External StorageDirectory
      final directory = await getExternalStorageDirectory();
      String mainDir =
          // directory!.path.replaceFirst('Download/com.nizetech.flex_moviez', "");
          directory!.path.replaceFirst('com.nizetech.flex_moviez', "");

      // saving file in Downloads folder  of external storage directory of device
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
        log(myDir.toString());
        log('Downloaded File Path ==>${downloadedFile.path}');
        OpenFile.open(downloadedFile.path);
        // open file use open_file package
        // OpenFile.open(downloadedFile.path);

        onTap;
      }

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // showDialog(
      //     context: context,
      //     builder: (ctx) => Dialog(
      //           elevation: 10,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(10),
      //             side: BorderSide(color: Colors.red, width: 2),
      //           ),
      //           child: Container(
      //             padding: const EdgeInsets.all(20),
      //             child: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               children: <Widget>[
      //                 Text(
      //                   "How To Complete Download",
      //                   style: Theme.of(context).textTheme.headline5,
      //                 ),
      //                 SizedBox(height: 20),
      //                 Text(
      //                     "1. Proceed to Install Flud Torrent Downloader and Open it"),
      //                 SizedBox(height: 10),
      //                 Text(
      //                     "2. Click on + icon and locate Internal Storage/JMovies/Downloads"),
      //                 SizedBox(height: 10),
      //                 Text(
      //                     "3. Select the Movie File and Click + icon to start Download"),
      //                 SizedBox(height: 10),
      //                 Center(
      //                   child: RaisedButton(
      //                     color: Colors.red.withOpacity(.2),
      //                     elevation: 0,
      //                     child: Text(
      //                       "Continue Download",
      //                       style: TextStyle(
      //                           color: Colors.black,
      //                           fontWeight: FontWeight.bold),
      //                     ),
      //                     shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(10),
      //                       side: BorderSide(width: 2, color: Colors.red),
      //                     ),
      //                     onPressed: () async {
      //                       bool isFludInstalled =
      //                           await DeviceApps.isAppInstalled(
      //                               "com.delphicoder.flud");
      //                       if (isFludInstalled) {
      //                         MyLogic.openFileChannel(
      //                           filePath: downloadedFile.path,
      //                         );
      //                       } else {
      //                         AndroidIntent intent = AndroidIntent(
      //                           action: "action_view",
      //                           data: Uri.encodeFull(
      //                               "market://details?id=com.delphicoder.flud"),
      //                         );
      //                         intent.launch();
      //                       }
      //                     },
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ));
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

Widget loader({Color? color}) => LoadingAnimationWidget.threeRotatingDots(
      color: color ?? mainColor,
      size: 100,
    );
