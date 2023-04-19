import 'package:flutter/material.dart';

Widget noInternet({required VoidCallback onTap}) => Center(
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
            onPressed: onTap,
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
