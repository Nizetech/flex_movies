import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../key/api_key.dart';
import '../../screens/widgets/widgets.dart';

Box box = Hive.box(kAppName);
List totalWatchlist = box.get('watchlist');

class FavoriteNotifier extends StateNotifier<List> {
  FavoriteNotifier() : super(totalWatchlist);

  void addFavorite(Map movie) {
    state = [...state, movie];
    box.put('watchlist', state);
  }

  void removeFavorite(Map movie) {
    state = state.where((element) => element['id'] != movie['id']).toList();
    box.put('watchlist', state);
  }

  void clearFavorite() {
    state = [];
    box.put('watchlist', state);
  }

  bool isFavorite(Map movie) {
    return state.any((element) => element['id'] == movie['id']);
  }

  int get totalFavorite => state.length;

  List get favorite => state;

  // bool _isFavorites = false;

  // bool get isFavorites => _isFavorites;

  bool get isFavoriteEmpty => state.isEmpty;
  bool get isFavoriteNotEmpty => state.isNotEmpty;

  void updateFavorite(List movie) {
    state = movie;
    box.put('watchlist', state);
  }

  void updateFavoriteById(Map movie) {
    state = state.map((e) {
      if (e['id'] == movie['id']) {
        return movie;
      } else {
        return e;
      }
    }).toList();
    box.put('watchlist', state);
  }

  void toggleFavorite(Map movie) {
    state = state.map((e) {
      if (e['id'] == movie['id']) {
        e['isFavorite'] = !e['isFavorite'];
        addFavorite(movie);
        log('Added ==> $movie to watchlist,=====> $movie');
        showToast('Added to watchlist');
        return e;
      } else {
        removeFavorite(movie);
        print('Removed ==> $movie from watchlist,=====> $movie');
        showErrorToast('Removed from watchlist');
        return e;
      }
    }).toList();
    box.put('watchlist', state);
  }

  // void toggleFavorites() {
  //   _isFavorites = !_isFavorites;
  // }
  // total favorite

  // void updateFavoriteByIdAndKey(Map movie, String key) {
  //   state = state.map((e) {
  //     if (e['id'] == movie['id']) {
  //       e[key] = movie[key];
  //       return e;
  //     } else {
  //       return e;
  //     }
  //   }).toList();
  //   box.put('watchlist', state);
  // }

  // void updateFavoriteByIdAndKeyAndValue(Map movie, String key, dynamic value) {
  //   state = state.map((e) {
  //     if (e['id'] == movie['id']) {
  //       e[key] = value;
  //       return e;
  //     } else {
  //       return e;
  //     }
  //   }).toList();
  //   box.put('watchlist', state);
  // }

}

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, List>((ref) {
  return FavoriteNotifier();
});

// final favoriteSelected = Provider<List>((ref) {
//   return ref
//       .watch(favoriteProvider)
//       .where((element) => element['isFavorite'] == true)
//       .toList();
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
