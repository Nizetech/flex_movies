import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/provider/watch_list_provider.dart';
import '../../utils/colors.dart';

Widget torrentList({required String size, required int index}) {
  return Consumer(builder: (context, ref, child) {
    final torrentList = ref.watch(torrentSizeProvider);
    return RadioListTile<int>(
        activeColor: mainColor,
        title: Text(
          size,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        value: index,
        groupValue: torrentList,
        onChanged: (val) {
          ref.read(torrentSizeProvider.notifier).state = val!;
        });
  });
}
