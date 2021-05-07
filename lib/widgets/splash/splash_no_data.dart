import 'package:flutter/material.dart';

class _FullScreenNoDataWidget extends StatelessWidget {
  const _FullScreenNoDataWidget(
      {Key? key, required this.imgUrl, required this.message})
      : super(key: key);
  final String message;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrientationBuilder(
        builder: (context, orientation) {
          double width = (orientation == Orientation.landscape
              ? MediaQuery.of(context).size.height * 0.4
              : MediaQuery.of(context).size.width * 0.5);
          return Align(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                constraints: BoxConstraints(
                  minWidth: 100,
                  minHeight: 100,
                  maxWidth: width,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.1),
                          child: Image.asset(
                            this.imgUrl,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            this.message,
                            style: Theme.of(context).textTheme.headline5,
                            maxLines: 1,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

enum FullScreenNoData { task, history }

extension FullScreenNoDataCatalogEx on FullScreenNoData {
  _FullScreenNoDataWidget buildSplashScreen() {
    switch (this) {
      case FullScreenNoData.history:
        return _FullScreenNoDataWidget(
          imgUrl: 'assets/images/illustrations/todo_women.png',
          message: 'No Achieved Task',
        );
      case FullScreenNoData.task:
        return _FullScreenNoDataWidget(
          imgUrl: 'assets/images/illustrations/todo_men.png',
          message: 'No Ongoing Task',
        );
    }
  }
}
