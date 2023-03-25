import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/movie.dart';
import 'top_level_providers.dart';

class WatchListController extends StateNotifier<List<Movie>> {
  WatchListController(this.ref) : super([]) {
    seed();
  }
  final Ref ref;

  void seed() {
    state = [...ref.read(watchListBoxProvider).values.toList()];
  }

  Future<WatchListToggleType> toggleWatchList(Movie movie) async {
    if (isPresent(movie)) {
      await ref.read(watchListBoxProvider).delete(movie.id);
      seed();
      return WatchListToggleType.removed;
    } else {
      await ref.read(watchListBoxProvider).put(movie.id, movie);
      seed();
      return WatchListToggleType.added;
    }
  }

  bool isPresent(Movie movie) {
    return state.contains(movie);
  }
}

final watchListControllerProvider =
    StateNotifierProvider<WatchListController, List<Movie>>((ref) {
  return WatchListController(ref);
});

enum WatchListToggleType { added, removed }
