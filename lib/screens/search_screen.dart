import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  // final List movie;
  // final List suggestion;
  SearchScreen({
    Key? key,
    // required this.movie, required this.suggestion
  }) : super(key: key);
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: SizedBox(),
        title: TextField(
          controller: search,
          autofocus: true,
          cursorColor: Colors.white,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: 'Search',

            prefixIcon: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: Colors.grey,
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
