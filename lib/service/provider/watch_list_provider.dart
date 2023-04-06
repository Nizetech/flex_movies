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

  // void addFavorite(Map movie) {
  //   state = [...state, movie];
  //   // box.put('isFavorite', true);
  //   box.put(movie['id'], state);
  // }

  // void removeFavorite(Map movie) {
  //   state = state.where((element) => element['id'] != movie['id']).toList();
  //   // box.put('isFavorite', true);

  //   box.put(movie['id'], state);
  // }

  void clearFavorite() {
    state = [];
    final key = [];
    for (var movie in state) {
      key.add(movie['id']);
    }
    // box.deleteAll(key);
  }

  // bool isFavorite(Map movie) {
  //   return state.any((element) => element['id'] == movie['id']);
  // }

  int get totalFavorite => state.length;

  List get favorite => state;

  // bool _isFavorites = false;

  // bool get isFavorites => _isFavorites;

  bool get isFavoriteEmpty => state.isEmpty;
  bool get isFavoriteNotEmpty => state.isNotEmpty;

  bool isPresent(Map movie) {
    return state.contains(movie['id']);
  }

  Future<WatchListType> toggleFavorite(Map movie) {
    //? Start Here
    if (isPresent(movie)) {
      state.remove(movie['id']);
      box.put(kWatchList, state);
      seed();
      return Future.value(WatchListType.removed);
    } else {
      state.add(movie['id']);
      box.put(kWatchList, state);
      seed();
      return Future.value(WatchListType.added);
    }
  }
}

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, List>((ref) {
  return FavoriteNotifier(ref);
});

// bool favorite = box.get('isFavorite', defaultValue: false);

// class WatchlistNotifier extends StateNotifier<bool> {
//   WatchlistNotifier() : super(favorite);

//   void toggleWatchlist(
//     String id,
//     bool value,
//   ) {
//     // bool value =
//     //     totalWatchlist.where((element) => element['id'] == id).isNotEmpty;
//     // if (value) {
//     //   state = false;
//     // } else {
//     //   state = true;
//     // }
//     state = !state;
//     box.put('isFavorite', state);
//   }

//   bool get isWatchlist => state;
// }

// final watchlistProvider = StateNotifierProvider<WatchlistNotifier, bool>((ref) {
//   return WatchlistNotifier();
// });

// final watchlist = Provider<bool>((ref) {
//   return ref.watch(watchlistProvider);
// });

class ThemeNotifier extends StateNotifier<bool> {
  // bool _isFavorite = false;
  // bool get isFavorite => _isFavorite;
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

final sliderProvider = StateProvider<double>((ref) => 3);

// final sliderValue = Provider<double>((ref) {
//   return ref.watch(sliderProvider);
// });

final basicSlider = StateProvider<double>((ref) => 3);
