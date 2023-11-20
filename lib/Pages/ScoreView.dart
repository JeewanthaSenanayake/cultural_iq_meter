import 'dart:async';
import 'dart:developer';
import 'package:cultural_iq_meter/Pages/MainMenu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

class ScoreView extends StatefulWidget {
  dynamic qDataList, userData;
  int timeTacken, num, leval;
  ScoreView(
      {super.key,
      required this.qDataList,
      required this.timeTacken,
      required this.num,
      required this.leval,
      required this.userData});

  @override
  State<ScoreView> createState() =>
      _ScoreViewState(qDataList, timeTacken, num, leval, userData);
}

class _ScoreViewState extends State<ScoreView> {
  dynamic qDataList, userData;
  int timeTacken, num, leval;
  _ScoreViewState(
      this.qDataList, this.timeTacken, this.num, this.leval, this.userData);

  double calculateMarks(response, int ttime) {
    double marks = 0;
    double multiplayer = leval == 1
        ? 10
        : leval == 2
            ? 20
            : 30;
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
    if (ttime >= num * 7) {
      timeBasedMark = 35.0 - ((ttime - (num * 7)) ~/ 5);
    } else {
      timeBasedMark = 35.0;
    }

    if (timeBasedMark < 0) {
      timeBasedMark = 0;
    }

    marks = marks + marks * (timeBasedMark / 100);

    return double.parse(marks.toStringAsFixed(2));
  }

  double totalMarks = 0;
  late Timer _timer;
  double _counter = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalMarks = calculateMarks(qDataList, timeTacken);
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (_counter < totalMarks) {
        setState(() {
          _counter = _counter + 1.0;
        });
      } else {
        _counter = totalMarks;
        _timer.cancel(); // Stop the timer when the counter reaches 100

      }
    });
  }

  bool _isLoading = false;
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
                  "${_counter}",
                  style:
                      TextStyle(color: Colors.white, fontSize: scrnwidth * 0.3),
                ),
                Text(
                  "\nName : ${userData['name']}",
                  style: TextStyle(
                      color: Colors.white, fontSize: scrnwidth * 0.05),
                ),
                Text(
                  "\nLeval : ${leval == 1 ? "Easy" : leval == 2 ? "Medium" : "Hard"}\n\n\n",
                  style: TextStyle(
                      color: Colors.white, fontSize: scrnwidth * 0.05),
                ),
                ElevatedButton(
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Continue'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        fixedSize: Size(scrnwidth * 0.25, scrnheight * 0.05)),
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      print(userData);
                      final response = await http.post(Uri.parse(
                          'https://cultural-iq-meter.onrender.com/iq_meter/api/v1/users/submit_score/${userData['uid']}/$totalMarks/$leval'));
                      print(response.statusCode);
                      if (response.statusCode == 200) {
                        setState(() {
                          _isLoading = false;
                        });
                        dynamic userData = jsonDecode(response.body);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MainMenu(
                                  userData: userData["data"],
                                )));
                      } else {
                        setState(() {
                          _isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Something went wrong, try again"),
                          ),
                        );
                      }
                      print(totalMarks);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
