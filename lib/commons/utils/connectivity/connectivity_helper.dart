import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class ConnectivityHelper {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  Function handleResumeWC = () => '';

  ConnectivityHelper() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    initConnectivity();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        await handleResume();
        _connectionStatus = result.toString();
        break;

      case ConnectivityResult.mobile:
        await handleResumeWC();
        _connectionStatus = result.toString();
        break;
      case ConnectivityResult.none:
        _connectionStatus = result.toString();
        break;
      default:
        _connectionStatus = 'Failed to connected to Internet.';
        break;
    }

    print("status:" + _connectionStatus);
  }

  Future<void> handleResume() async {
    if (_connectionStatus == null) return;
    if (_connectionStatus != ConnectivityResult.none.toString()) return;
    handleResumeWC();
  }
}
