import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:noname/screens/home/widgets/discover_tab.dart';
import 'package:noname/screens/widgets/tab_bar.dart';

class ChannelScreen extends StatelessWidget {
  ScrollController listViewScrollController = new ScrollController();

  PageController pageController = PageController();
  GlobalKey<CategoriesState> categoryState = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size(screenWidth, 60),
        child: Categories(
          key: categoryState,
          categories: ["All", "Internship", "Volunteer", "Full-Time"],
          parentPageController: pageController,
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          categoryState.currentState.changeCategoryIndex(index);
        },
        children: [
          DiscoverTab(),
          CareerListCategories(),
          CareerListCategories(),
          CareerListCategories(),
        ],
      ),
    );
  }
}

class CareerListCategories extends StatelessWidget {
  const CareerListCategories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: RefreshIndicator(
        displacement: 30,
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2), () => true);
        },
        child: ListView(
          children: [
            ...List<int>.generate(4, (int index) => 5).map((e) => careerItem()),
          ],
        ),
      ),
    );
  }

  Padding careerItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Software Engineering Internship",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[500]),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "Kuala Lumpur Malaysia",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600]),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "2 Position, UTHOPIA SDN BHD",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[600]),
              ),
            ],
          )),
    );
  }
}

/*
TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
 */
List<Widget> get items => [1, 2, 3]
    .map((e) => Container(
          width: 400,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [],
          ),
        ))
    .toList();

class BottomBar extends StatefulWidget {
  Function onPressed;
  bool bottomIcons;
  String text;
  IconData icons;
  BottomBar(
      {@required this.onPressed,
      @required this.bottomIcons,
      @required this.icons,
      @required this.text});
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onPressed,
        child: widget.bottomIcons == true
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      widget.icons,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.text,
                      style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
              )
            : Icon(widget.icons));
  }
}

class Job {
  final String jobTitle;
  final String jobDescription;
  final String jobLocation;
  final String jobPeriod;
  final String jobType;
  final String jobOrganization;
  final String jobRequirement;
  final int jobPositions;
  final int jobMinSalary;
  final int jobMaxSalary;

  Job({
    @required this.jobTitle,
    @required this.jobDescription,
    @required this.jobLocation,
    @required this.jobPeriod,
    @required this.jobType,
    @required this.jobOrganization,
    @required this.jobRequirement,
    @required this.jobPositions,
    @required this.jobMinSalary,
    @required this.jobMaxSalary,
  });
}

final Job internJob = new Job(
  jobTitle: "Software Developer Intern",
  jobDescription: "Flutter",
  jobLocation: "Kuala Lumpur Malaysia",
  jobPeriod: "3 months",
  jobType: "Internship",
  jobOrganization: "UTHOPIA Sdn Bhd",
  jobRequirement: "Experience with Flutter",
  jobPositions: 2,
  jobMaxSalary: 1200,
  jobMinSalary: 1500,
);
