import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../key/api_key.dart';
import '../../screens/widgets/widgets.dart';

Box box = Hive.box(kAppName);
final totalWatchlist = box.get(kWatchList, defaultValue: []);

// final watchListBoxProvider = Provider.autoDispose<Box>((_) {
//   return Hive.box(kWatchList);
// });

enum WatchListType { added, removed }

class FavoriteNotifier extends StateNotifier<List> {
  FavoriteNotifier(this.ref) : super(totalWatchlist) {
    seed();
  }
  final Ref ref;

  void seed() {
    state = [...state];
  }

  void clearFavorite() {
    state = [];
    box.put(kWatchList, state);
    seed();
  }

  void removeFavorite(Map movie) {
    state.removeWhere((element) => element['id'] == movie['id']);
    box.put(kWatchList, state);
    seed();
    // state = state;
  }

  int get totalFavorite => state.length;

  List get favorite => state;

  bool get isFavoriteEmpty => state.isEmpty;
  bool get isFavoriteNotEmpty => state.isNotEmpty;

  bool isPresent(Map movie) {
    return state.where((element) => element['id'] == movie['id']).isNotEmpty;
    // return state.contains(movie);
  }

  Future<WatchListType> toggleFavorite(Map movie) {
    //? Start Here
    if (isPresent(movie)) {
      state.removeWhere((element) => element['id'] == movie['id']);
      box.put(kWatchList, state);
      seed();
      return Future.value(WatchListType.removed);
    } else {
      state.add(movie);
      box.put(kWatchList, state);
      seed();
      return Future.value(WatchListType.added);
    }
  }
}

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, List>((ref) {
  return FavoriteNotifier(ref);
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false);
  bool get isDark => state;
  void toggleTheme() => state = !state;
}

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

/// <====== Category Screen ======> ///

class genreNotifier extends StateNotifier<String> {
  genreNotifier() : super('Action');

  void updateGenre(String genre) {
    state = genre;
  }

  bool isGenre(String genre) {
    return state == genre;
  }
}

final genreProvider = StateNotifierProvider<genreNotifier, String>((ref) {
  return genreNotifier();
});

final genreSelected = Provider<String>((ref) {
  return ref.watch(genreProvider);
});

/// <====== Page Increment ======> ///
class PageCounter extends StateNotifier<int> {
  PageCounter() : super(1);

  void incrementPage() => state++;
}

final pageProvider = StateNotifierProvider<PageCounter, int>((ref) {
  return PageCounter();
});

/// <====== Slider Provider ======> ///

final sliderProvider = StateProvider.autoDispose<double>((ref) => 3);

// final basicSlider = StateProvider.autoDispose<double>((ref) => 3);

/// <====== DateTime Provider ======> ///
class DateNotifier extends StateNotifier<DateTime> {
  DateNotifier() : super(DateTime.now());
  void updateDate(DateTime date) {
    state = date;
  }
}

final dateProvider = StateNotifierProvider<DateNotifier, DateTime>((ref) {
  return DateNotifier();
});

final yearProvider = Provider<int>((ref) {
  return ref.watch(dateProvider).year;
});
