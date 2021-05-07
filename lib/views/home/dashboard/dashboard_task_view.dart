import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:todonote/navigation/custom_page_route/custom_page_route.dart';
import 'package:todonote/views/add_todo/add_todo_screen.dart';
import 'package:todonote/views/home/dashboard/widgets/todo_task_tile.dart';
import 'package:todonote/views/home/podcast_detail_screen.dart';
import 'package:todonote/state/providers/global/globalProvider.dart';
import 'package:todonote/state/providers/local/search_provider.dart';
import 'package:todonote/widgets/splash/splash_no_data.dart';

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
          Consumer(
            builder: (context, watch, child) {
              List<TodoTask> todos = watch(GlobalProvider.todoProvider).tasks;
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: todos.length > 0
                    ? SafeArea(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            //Padding(
                            //  padding: const EdgeInsets.all(12),
                            //  child: Theme(
                            //    data: Theme.of(context).copyWith(
                            //        colorScheme: Theme.of(context)
                            //            .colorScheme
                            //            .copyWith(
                            //                primary: Theme.of(context)
                            //                    .primaryColorDark)),
                            //    child: CupertinoSearchTextField(
                            //      backgroundColor: Colors.transparent,
                            //      controller: _searchController,
                            //      focusNode: _focusNode,
                            //      onChanged: (val) =>
                            //          onSearchFieldChanged(val, context),
                            //      itemSize: 25,
                            //      padding: const EdgeInsetsDirectional.fromSTEB(
                            //          5.8, 10, 5, 10),
                            //    ),
                            //  ),
                            //),
                            SingleChildScrollView(
                              child: Column(children: [
                                Text("Incoming",
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                ...todos.map((e) =>
                                    TodoTaskTile(context: context, e: e)),
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  "Ongoing",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Text(
                                  "Overdue",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ]),
                            ),
                          ],
                        ),
                      )
                    : FullScreenNoData.task.buildSplashScreen(),
              );
            },
          ),

          //Consumer(
          //  builder: (context, watch, child) {
          //    List<TodoTask> todos = watch(filteredTodoListProvider);
          //    return AnimatedSwitcher(
          //      duration: const Duration(milliseconds: 300),
          //      child: todos.length == 0
          //          ? FullScreenNoData.task.buildSplashScreen()
          //          : SizedBox(),
          //    );
          //  },
          //),
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
