import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/state/providers/global/globalProvider.dart';

class SearchProvider extends StateNotifier<SearchState> {
  SearchProvider() : super(new SearchState(results: []));
  void searchUser() => searchUser();
  Future<void> fetchData(String keyword) async {
    state = SearchState(results: [], status: SearchStatus.loading);
    Future.delayed(Duration(seconds: 2), () => state = state.search(keyword));
  }
}

class SearchState {
  List<TodoTask> results;
  SearchStatus status;
  SearchState({required this.results, this.status = SearchStatus.none});

  SearchState search(String id) {
    return SearchState(results: []);
  }
}

enum SearchStatus { none, loading, doneWithResults, doneWithEmptyResult }
