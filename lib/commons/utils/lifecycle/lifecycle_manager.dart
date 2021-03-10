import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:noname/commons/utils/services/stoppable_sevice.dart';

/// A Widget that will wrap all the managers into one widget
///   - to add another manager just wrap the widget
///     or add the new widget as a child of the current widget(s)
class CoreManager extends StatelessWidget {
  final Widget child;

  const CoreManager({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child: child,
    );
  }
}

/// A manager to start/stop [StoppableService]s when the app goes/returns into/from the background
class LifeCycleManager extends StatefulWidget {
  final Widget child;

  const LifeCycleManager({Key? key, required this.child}) : super(key: key);

  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  final _log = Logger('LifeCycleManager');
  final servicesToManage = <StoppableService>[];

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _log.fine('App life cycle change to $state');
    servicesToManage.forEach((service) {
      if (state == AppLifecycleState.resumed) {
        service.start();
      } else {
        service.stop();
      }
    });
  }
}
