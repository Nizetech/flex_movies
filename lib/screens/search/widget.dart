import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

Widget searchError() => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/search_error.png',
              width: Get.width * .7,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Movie Not Found\n Search Again',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              height: 1.5,
              color: white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
