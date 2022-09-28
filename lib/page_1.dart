import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conn_realtime/page_2.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Pageone extends StatefulWidget {
  const Pageone({super.key});

  @override
  State<Pageone> createState() => _PageoneState();
}

class _PageoneState extends State<Pageone> {
  late StreamSubscription connSub;
  var isDeviceConnected = false;
  bool isAlert = false;

  getConnectivity() {
    return connSub = Connectivity().onConnectivityChanged.listen((event) async {
      if (kDebugMode) {
        print('running');
      }
      isDeviceConnected = await InternetConnectionChecker().hasConnection;

      if (kDebugMode) {
        print(isDeviceConnected);
      }

      if (!isDeviceConnected && isAlert == false) {
        showDialogBox();
        setState(() => isAlert = true);
      } else {
        setState(() => isAlert = false);
      }
    });
  }

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  @override
  void dispose() {
    connSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connectivity checker"),
      ),
      body: Center(
        // child: isAlert == true
        //     ? ElevatedButton(
        //         onPressed: () async {
        //           setState(() => isAlert = false);

        //           isDeviceConnected =
        //               await InternetConnectionChecker().hasConnection;
        //           if (!isDeviceConnected) {
        //             showDialogBox();
        //             setState(() => isAlert = true);
        //           }
        //         },
        //         child: const Text("Reload"))
        //     :
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const Pagetwo();
                  },
                ),
              );
            },
            child: const Text("Page 2")),
      ),
    );
  }

  showDialogBox() {
    return showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("No Connection"),
          content: const Text("Please check your internet connectivity"),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                setState(() => isAlert = false);

                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() => isAlert = true);
                }
              },
              child: const Text("Ok"),
            )
          ],
        );
      },
    );
  }
}
