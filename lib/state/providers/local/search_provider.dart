import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchProvider extends StateNotifier<SearchState> {
  SearchProvider() : super(new SearchState(users: [], podcasts: []));
  void searchUser() => searchUser();
  Future<void> fetchData(String keyword) async {
    state = SearchState(users: [], podcasts: [], isFetching: true);
    Future.delayed(Duration(seconds: 2),
        () => state = SearchState(users: [], podcasts: []));
  }
}

class SearchState {
  List<SearchedUser> users;
  List<SearchedPodcast> podcasts;
  SearchState(
      {required this.users, required this.podcasts, this.isFetching = false});

  bool isFetching;
}

String getId() => "fergef";

class SearchedUser {
  final String sId;
  String userName;
  String userEmail;
  SearchedUser({required this.userName, required this.userEmail, userId})
      : sId = userId ?? getId();
}

class SearchedPodcast {
  final String sId;
  String userName;
  String userEmail;
  SearchedPodcast({required this.userName, required this.userEmail, userId})
      : sId = userId ?? getId();
}
