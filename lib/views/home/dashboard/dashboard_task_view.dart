import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:noname/navigation/custom_page_route/custom_page_route.dart';
import 'package:noname/views/add_todo/add_todo_screen.dart';
import 'package:noname/views/home/podcast_detail_screen.dart';
import 'package:noname/state/providers/global/globalProvider.dart';
import 'package:noname/state/providers/local/search_provider.dart';

class DashboardTaskView extends StatelessWidget {
  static const String route = "/search_screen";
  FocusNode _focusNode = new FocusNode();
  final searchProvider =
      StateNotifierProvider.autoDispose<SearchProvider, SearchState>((ref) {
    return SearchProvider();
  });

  final TextEditingController _searchController = new TextEditingController();
  final _debouncer = Debouncer(delay: Duration(milliseconds: 0));

  void onSearchFieldChanged(String val, BuildContext context) {
    _debouncer.call(() => context.read(searchProvider.notifier).fetchData(val));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final filteredTodoListProvider =
        Provider.autoDispose<List<TodoTask>>((ref) {
      final filter = ref.watch(searchProvider);
      final todos = ref.watch(GlobalProvider.todoProvider);

      return filter.results.length > 0 ? filter.results : todos.tasks;
    });
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: Theme.of(context).primaryColorDark)),
                  child: CupertinoSearchTextField(
                    backgroundColor: Colors.transparent,
                    controller: _searchController,
                    focusNode: _focusNode,
                    onChanged: (val) => onSearchFieldChanged(val, context),
                    itemSize: 25,
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(5.8, 10, 5, 10),
                  ),
                ),
              ),
              Expanded(
                child: Consumer(
                  builder: (context, watch, child) {
                    List<TodoTask> todos = watch(filteredTodoListProvider);
                    return SingleChildScrollView(
                      child: Column(
                          children: todos
                              .map((e) => RawMaterialButton(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    splashColor: Colors.black,
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, PodcastDetailPage.route);
                                    },
                                    child: InkWell(
                                      onLongPress: () {
                                        Navigator.of(context).push(
                                            CustomPageRoute.verticalTransition(
                                                AddEditTodoScreen(
                                                    todoTask: e)));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        Colors.black
                                                            .withOpacity(0.4),
                                                        Colors.black
                                                            .withOpacity(0.2),
                                                      ]),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(e.title,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(
                                                              color: Colors
                                                                  .white)),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    context
                                                        .read(GlobalProvider
                                                            .todoProvider
                                                            .notifier)
                                                        .removeTodo(e);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child:
                                                        Icon(Icons.done_sharp),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList()),
                    );
                  },
                ),
              )
            ],
          ),
          Consumer(
            builder: (context, watch, child) {
              return watch(searchProvider).status == SearchStatus.loading
                  ? Center(
                      child: Container(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator()),
                    )
                  : SizedBox();
            },
          )
        ],
      ),
    );
  }
}
