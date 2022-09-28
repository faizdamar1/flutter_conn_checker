import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

getConnectivity(StreamSubscription sub) {
  Connectivity().onConnectivityChanged.listen((result) async {});
}
