import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PollBarChart extends StatefulWidget {
  List<Options> options;
  final List<Color> barColors;

  PollBarChart({
    @required this.options,
    @required this.barColors,
  });
  @override
  State<StatefulWidget> createState() => PollBarChartState();
}

class PollBarChartState extends State<PollBarChart> {
  static const double barWidth = 22;

  List<BarChartRodStackItem> items = [];
  int sum = 0;
  bool showZero = true;
  @override
  void initState() {
    super.initState();
    if (widget.options.length == 0) return;

    Future.delayed(Duration.zero, () {
      Future.delayed(
          Duration(milliseconds: 100),
          () => setState(() {
                showZero = false;
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width * 0.85;
    sum = widget.options
        .map((e) => e.count)
        .toList()
        .reduce((value, element) => value += element);
    return Center(
      child: widget.options.length == 0
          ? Container()
          : ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: screenWidth,
                height: 40,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    ...List.generate(
                        widget.options.length,
                        (index) => AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              width: showZero
                                  ? 0
                                  : (screenWidth *
                                      (widget.options[index].count) /
                                      sum),
                              color: widget.barColors[index].withOpacity(0.5),
                            ))
                  ],
                ),
              ),
            ),
    );
  }
}

class Options {
  String optionName;
  int count;

  Options({this.optionName, this.count});

  Options.fromJson(Map<String, dynamic> json) {
    optionName = json['option_name'];
    count = json['count'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_name'] = this.optionName;
    return data;
  }
}
