import 'dart:async';

import 'package:flutter/material.dart';

class ScoreView extends StatefulWidget {
  dynamic qDataList;
  int timeTacken, num, leval;
  ScoreView(
      {super.key,
      required this.qDataList,
      required this.timeTacken,
      required this.num,
      required this.leval});

  @override
  State<ScoreView> createState() =>
      _ScoreViewState(qDataList, timeTacken, num, leval);
}

class _ScoreViewState extends State<ScoreView> {
  dynamic qDataList;
  int timeTacken, num, leval;
  _ScoreViewState(this.qDataList, this.timeTacken, this.num, this.leval);

  double calculateMarks(response, int ttime) {
    double marks = 0;
    double multiplayer = 90 / num;
    for (var element in response['questions']) {
      try {
        if (element["selected_ans"] == element["correct_ans"]) {
          marks = marks + multiplayer;
        }
      } catch (e) {
        print(e.toString());
      }
    }
    double timeBasedMark = 0.0;
    if (ttime > num * 10) {
      timeBasedMark = 10.0 - ((ttime - (num * 10)) ~/ 10);
    } else {
      timeBasedMark = 10.0;
    }

    if (timeBasedMark < 0) {
      timeBasedMark = 0;
    }

    return marks == 0
        ? 0
        : (marks.ceilToDouble() + timeBasedMark) >= 100
            ? 100
            : (marks.ceilToDouble() + timeBasedMark);
  }

  double totalMarks = 0;
  late Timer _timer;
  int _counter = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalMarks = calculateMarks(qDataList, timeTacken);
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (_counter < totalMarks) {
        setState(() {
          _counter++;
        });
      } else {
        _timer.cancel(); // Stop the timer when the counter reaches 100

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double scrnwidth = MediaQuery.of(context).size.width;
    double scrnheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Score"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  "\nCultural IQ Meter\n",
                  style:
                      TextStyle(color: Colors.white, fontSize: scrnwidth * 0.1),
                ),
                Text(
                  "${_counter}%",
                  style:
                      TextStyle(color: Colors.white, fontSize: scrnwidth * 0.3),
                ),
                Text(
                  "\nName : Jeewantha",
                  style: TextStyle(
                      color: Colors.white, fontSize: scrnwidth * 0.05),
                ),
                Text(
                  "\nLeval : ${leval == 1 ? "Easy" : leval == 2 ? "Medium" : "Hard"}\n\n\n",
                  style: TextStyle(
                      color: Colors.white, fontSize: scrnwidth * 0.05),
                ),
                ElevatedButton(
                  child: const Text('Continue'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      fixedSize: Size(scrnwidth * 0.25, scrnheight * 0.05)),
                  onPressed: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //         builder: (context) => ScoreView(
                    //             )));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
