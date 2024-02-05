import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:free_time/media_query.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DateTime startDate;
  late DateTime endDate;

  void resolveDateRange(Future<DateTimeRange?> pickedRange) {
    pickedRange.then((resolvedRange) {
      if (resolvedRange == null) {
        // Print some toast saying that nothing was selected
        print("failed to collect values");
      } else {
        setState(
          () => {startDate = resolvedRange.start, endDate = resolvedRange.end},
        );
        print(startDate.toString());
        print(endDate.toString());
      }
    });
  }

  void handleDatePick(BuildContext context) {
    Future<DateTimeRange?> range = showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) => AlertDialog(
        content: Container(
          height: context.height * 0.7,
          width: context.width * 0.3,
          child: child,
        ),
      ),
    );
    resolveDateRange(range);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: context.width * 0.5,
            height: context.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Please Login:"),
                ElevatedButton(child: const Text("Login"), onPressed: () {}),
                const Text("or"),
                const Text("Upload a calendar file:"),
                ElevatedButton(child: const Text("Upload"), onPressed: () {}),
              ],
            ),
          ),
          Container(
            width: context.width * 0.5,
            height: context.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Start Date: None Selected"),
                const Text("End Date Date: None Selected"),
                ElevatedButton(
                  onPressed: () {
                    handleDatePick(context);
                    print("clicked");
                  },
                  child: const Text("Pick a Date Range"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
