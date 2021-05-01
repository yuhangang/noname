import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/commons/constants/models/time_line.dart';
import 'package:noname/commons/utils/Date/dateUtils.dart';
import 'package:noname/views/home/dashboard/widgets/timeline_item.dart';
import 'package:noname/state/providers/global/globalProvider.dart';

class DashboardDateView extends StatelessWidget {
  const DashboardDateView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Consumer(
          builder: (context, watch, _) {
            List<TodoTask> todos = watch(GlobalProvider.todoProvider).tasks;
            if (todos.length > 1)
              todos.sort((a, b) {
                return (a.startTime.isBefore(b.startTime) ? 0 : 2).compareTo(1);
              });
            //print(todos.map((element) => print(element.startTime)));
            //print(DateTime(2021, 4, 18, 19, 01).dayDiff(DateTime.now()));
            //print(DateTime(2021, 4, 18, 19, 01).isSameDay(DateTime.now()));
            //print(DateTime(2021, 4, 17, 19, 01).laterThisWeek());
            DashBoardFilteredByDate categoriesTodo =
                DashBoardFilteredByDate(todos);
            //print("today ${categoriesTodo.today}");
            //print("tomorrow ${categoriesTodo.tomorrow}");
            //print(categoriesTodo.nextWeek);
            //print(categoriesTodo.other);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                //Padding(
                //  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                //  child: InkWell(
                //      borderRadius: BorderRadius.circular(10),
                //      onTap: () => Navigator.of(context)
                //          .push(CustomPageRoute.verticalTransition(SearchScreen())),
                //      child: AbsorbPointer(
                //          child: CupertinoSearchTextField(
                //        borderRadius: BorderRadius.circular(10),
                //        placeholder: "Search Tasks",
                //      ))),
                //),
                TimeLineItem(
                  title: "TODAY",
                  todoList: categoriesTodo.today,
                  timeLineTodo: TimeLineTodo.today,
                ),
                TimeLineItem(
                  title: "TOMORROW",
                  todoList: categoriesTodo.tomorrow,
                  timeLineTodo: TimeLineTodo.tomorrow,
                ),
                TimeLineItem(
                  title: "Later This Week",
                  todoList: categoriesTodo.laterThisWeek,
                  timeLineTodo: TimeLineTodo.laterThisWeek,
                ),
                TimeLineItem(
                  title: "Next Week",
                  todoList: categoriesTodo.nextWeek,
                  timeLineTodo: TimeLineTodo.nextWeek,
                ),
                TimeLineItem(
                  title: "All",
                  todoList: categoriesTodo.other,
                  timeLineTodo: TimeLineTodo.nextMonth,
                ),

                //Expanded(
                //  child: Consumer(
                //    builder: (context, watch, child) {
                //      List<TodoTask> tasks =
                //          watch(GlobalProvider.todoProvider.state).tasks;
                //      return ListView.builder(
                //          itemCount: tasks.length,
                //          itemBuilder: (_, index) {
                //            TodoTask task = tasks[index];
                //            return RawMaterialButton(
                //              materialTapTargetSize:
                //                  MaterialTapTargetSize.shrinkWrap,
                //              splashColor: Colors.black,
                //              padding: const EdgeInsets.all(0),
                //              onPressed: () {
                //                Navigator.pushNamed(
                //                    context, PodcastDetailPage.route);
                //              },
                //              child: InkWell(
                //                onTap: () {
                //                  context
                //                      .read(GlobalProvider.todoProvider)
                //                      .removeTodo(tasks[index].id);
                //                },
                //                onLongPress: () {
                //                  print(task.id);
                //                  Navigator.of(context).push(
                //                      CustomPageRoute.verticalTransition(
                //                          AddEditTodoScreen(
                //                    todoTask: task,
                //                  )));
                //                },
                //                child: Container(
                //                  height: 200,
                //                  decoration: BoxDecoration(
                //                      borderRadius: BorderRadius.circular(8)),
                //                  margin: const EdgeInsets.symmetric(
                //                      horizontal: 8, vertical: 8),
                //                  child: Stack(
                //                    children: [
                //                      ClipRRect(
                //                        borderRadius: BorderRadius.circular(8),
                //                        child: Image.asset(
                //                          'assets/images/intro_s.jpg',
                //                          fit: BoxFit.fitWidth,
                //                          width: 500,
                //                        ),
                //                      ),
                //                      ClipRRect(
                //                        borderRadius: BorderRadius.circular(8),
                //                        child: Container(
                //                          decoration: BoxDecoration(
                //                            gradient: LinearGradient(
                //                                begin: Alignment.topCenter,
                //                                end: Alignment.bottomCenter,
                //                                colors: [
                //                                  Colors.black.withOpacity(0.4),
                //                                  Colors.black.withOpacity(0.2),
                //                                ]),
                //                          ),
                //                        ),
                //                      ),
                //                      Column(
                //                        mainAxisAlignment:
                //                            MainAxisAlignment.spaceBetween,
                //                        crossAxisAlignment:
                //                            CrossAxisAlignment.start,
                //                        children: [
                //                          Padding(
                //                            padding: const EdgeInsets.all(10),
                //                            child: Column(
                //                              crossAxisAlignment:
                //                                  CrossAxisAlignment.start,
                //                              children: [
                //                                Text(task.title,
                //                                    style: Theme.of(context)
                //                                        .textTheme
                //                                        .headline5!
                //                                        .copyWith(
                //                                            color: Colors.white)),
                //                                Text(task.description,
                //                                    style: Theme.of(context)
                //                                        .textTheme
                //                                        .bodyText1!
                //                                        .copyWith(
                //                                            color:
                //                                                Colors.grey[300]))
                //                              ],
                //                            ),
                //                          ),
                //                          Row(
                //                            mainAxisAlignment:
                //                                MainAxisAlignment.end,
                //                            children: [
                //                              CustomIconButton(
                //                                icon: CupertinoIcons.add,
                //                                color: Colors.white,
                //                                onPressed: () => Navigator.of(
                //                                        context)
                //                                    .push(CustomPageRoute
                //                                        .verticalTransition(
                //                                            AudioPlayerSample())),
                //                              ),
                //                              CustomIconButton(
                //                                icon: CupertinoIcons.add,
                //                                color: Colors.white,
                //                                onPressed: () => AlertDialogHelper
                //                                    .showDetailDialog(),
                //                              ),
                //                            ],
                //                          ),
                //                        ],
                //                      ),
                //                    ],
                //                  ),
                //                ),
                //              ),
                //            );
                //          });
                //    },
                //  ),
                //),
              ],
            );
          },
        ),
      ),
    );
  }
}
