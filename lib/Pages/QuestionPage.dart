import 'dart:async';
import 'dart:ui';

import 'package:cultural_iq_meter/Pages/ScoreView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestionPage extends StatefulWidget {
  int leval, num;
  QuestionPage({super.key, required this.leval, required this.num});

  @override
  State<QuestionPage> createState() => _QuestionPageState(leval, num);
}

class _QuestionPageState extends State<QuestionPage> {
  int leval, num;
  _QuestionPageState(this.leval, this.num);
  bool loading = true;
  dynamic qData;
  int _seconds = 0;
  late Timer _timer;
  dynamic ansverdQList = [];
  Future getQuestions(int lvl, int number) async {
    final response = await http.get(Uri.parse(
        'https://cultural-iq-meter.onrender.com/iq_meter/api/v1/questions/get_questions/$lvl/$number'));

    //for timer
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _seconds++;
      });
    });

    if (response.statusCode == 200) {
      qData = json.decode(response.body);
      ansverdQList = createQList(qData);
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      return Exception('Failed to load data');
    }
  }

  double scrnwidth = 0;
  double scrnheight = 0;
  List<Container> ContainerList = [];

  dynamic createQList(data) {
    ContainerList = [];
    for (var i = 0; i < data['questions'].length; i++) {
      if (data['questions'][i]['img_url'] == '') {
        ContainerList.add(
          Container(
            margin: EdgeInsets.only(bottom: scrnheight * 0.055),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        data['questions'][i]["question"].toString(),
                        style: TextStyle(
                            color: Colors.white, fontSize: scrnheight * 0.02),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (data['questions'][i]['selected_ans'] == null) {
                          setState(() {
                            data['questions'][i]['selected_ans'] = "ans1";
                          });
                          ansverdQList = createQList(data);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            // color: Colors.white,
                            color: data['questions'][i]['selected_ans'] == null
                                ? Colors.white
                                : data['questions'][i]['selected_ans'] == "ans1"
                                    ? (data['questions'][i]['selected_ans'] ==
                                            data['questions'][i]['correct_ans']
                                        ? Colors.green
                                        : Colors.red)
                                    : Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            data['questions'][i]["ans1"].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: scrnheight * 0.02,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (data['questions'][i]['selected_ans'] == null) {
                          setState(() {
                            data['questions'][i]['selected_ans'] = "ans2";
                          });
                          ansverdQList = createQList(data);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            // color: Colors.white,
                            color: data['questions'][i]['selected_ans'] == null
                                ? Colors.white
                                : data['questions'][i]['selected_ans'] == "ans2"
                                    ? (data['questions'][i]['selected_ans'] ==
                                            data['questions'][i]['correct_ans']
                                        ? Colors.green
                                        : Colors.red)
                                    : Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            data['questions'][i]["ans2"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (data['questions'][i]['selected_ans'] == null) {
                          setState(() {
                            data['questions'][i]['selected_ans'] = "ans3";
                          });
                          ansverdQList = createQList(data);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            // color: Colors.white,
                            color: data['questions'][i]['selected_ans'] == null
                                ? Colors.white
                                : data['questions'][i]['selected_ans'] == "ans3"
                                    ? (data['questions'][i]['selected_ans'] ==
                                            data['questions'][i]['correct_ans']
                                        ? Colors.green
                                        : Colors.red)
                                    : Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            data['questions'][i]["ans3"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (data['questions'][i]['selected_ans'] == null) {
                          setState(() {
                            data['questions'][i]['selected_ans'] = "ans4";
                          });
                          ansverdQList = createQList(data);
                        }
                        print(data['questions'][i]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            // color: Colors.white,
                            color: data['questions'][i]['selected_ans'] == null
                                ? Colors.white
                                : data['questions'][i]['selected_ans'] == "ans4"
                                    ? (data['questions'][i]['selected_ans'] ==
                                            data['questions'][i]['correct_ans']
                                        ? Colors.green
                                        : Colors.red)
                                    : Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            data['questions'][i]["ans4"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                data['questions'][i]['selected_ans'] == null
                    ? Center(
                        child: Text(""),
                      )
                    : data['questions'][i]['selected_ans'] ==
                            data['questions'][i]['correct_ans']
                        ? Center(
                            child: Column(
                              children: [
                                Text(
                                  "\n😊",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: scrnheight * 0.035),
                                ),
                                Text(
                                  "Correct Answer",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: scrnheight * 0.02),
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Column(
                              children: [
                                Text(
                                  "\n😔",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: scrnheight * 0.035),
                                ),
                                Text(
                                  "Wrong Answer",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: scrnheight * 0.02),
                                ),
                                Text(
                                  "\nCorrect Answer is:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: scrnheight * 0.015),
                                ),
                                Text(
                                  "${data['questions'][i][(data['questions'][i]['correct_ans'])]}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: scrnheight * 0.02),
                                ),
                              ],
                            ),
                          ),
              ],
            ),
          ),
        );
      } else if ((data['questions'][i]['img_url'].runtimeType).toString() ==
          'List<dynamic>') {
        print("List");
        ContainerList.add(
          Container(
            margin: EdgeInsets.only(bottom: scrnheight * 0.055),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        data['questions'][i]["question"].toString(),
                        style: TextStyle(
                            color: Colors.white, fontSize: scrnheight * 0.02),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (data['questions'][i]['selected_ans'] == null) {
                          setState(() {
                            data['questions'][i]['selected_ans'] = "ans1";
                          });
                          ansverdQList = createQList(data);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        // width: scrnwidth * 0.8,
                        // height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            // color: Colors.white,
                            color: data['questions'][i]['selected_ans'] == null
                                ? Colors.white
                                : data['questions'][i]['selected_ans'] == "ans1"
                                    ? (data['questions'][i]['selected_ans'] ==
                                            data['questions'][i]['correct_ans']
                                        ? Colors.green
                                        : Colors.red)
                                    : Colors.white,
                          ),
                        ),
                        child: Center(
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/load-image.png'),
                            image:
                                NetworkImage("${data['questions'][i]["ans1"]}"),
                            height: scrnwidth * 0.45,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (data['questions'][i]['selected_ans'] == null) {
                          setState(() {
                            data['questions'][i]['selected_ans'] = "ans2";
                          });
                          ansverdQList = createQList(data);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        // width: scrnwidth * 0.8,
                        // height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            // color: Colors.white,
                            color: data['questions'][i]['selected_ans'] == null
                                ? Colors.white
                                : data['questions'][i]['selected_ans'] == "ans2"
                                    ? (data['questions'][i]['selected_ans'] ==
                                            data['questions'][i]['correct_ans']
                                        ? Colors.green
                                        : Colors.red)
                                    : Colors.white,
                          ),
                        ),
                        child: Center(
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/load-image.png'),
                            image:
                                NetworkImage("${data['questions'][i]["ans2"]}"),
                            height: scrnwidth * 0.45,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (data['questions'][i]['selected_ans'] == null) {
                          setState(() {
                            data['questions'][i]['selected_ans'] = "ans3";
                          });
                          ansverdQList = createQList(data);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        // width: scrnwidth * 0.8,
                        // height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            // color: Colors.white,
                            color: data['questions'][i]['selected_ans'] == null
                                ? Colors.white
                                : data['questions'][i]['selected_ans'] == "ans3"
                                    ? (data['questions'][i]['selected_ans'] ==
                                            data['questions'][i]['correct_ans']
                                        ? Colors.green
                                        : Colors.red)
                                    : Colors.white,
                          ),
                        ),
                        child: Center(
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/load-image.png'),
                            image:
                                NetworkImage("${data['questions'][i]["ans3"]}"),
                            height: scrnwidth * 0.45,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (data['questions'][i]['selected_ans'] == null) {
                          setState(() {
                            data['questions'][i]['selected_ans'] = "ans4";
                          });
                          ansverdQList = createQList(data);
                        }
                        print(data['questions'][i]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        // width: scrnwidth * 0.8,
                        // height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            // color: Colors.white,
                            color: data['questions'][i]['selected_ans'] == null
                                ? Colors.white
                                : data['questions'][i]['selected_ans'] == "ans4"
                                    ? (data['questions'][i]['selected_ans'] ==
                                            data['questions'][i]['correct_ans']
                                        ? Colors.green
                                        : Colors.red)
                                    : Colors.white,
                          ),
                        ),
                        child: Center(
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/load-image.png'),
                            image:
                                NetworkImage("${data['questions'][i]["ans4"]}"),
                            height: scrnwidth * 0.45,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                data['questions'][i]['selected_ans'] == null
                    ? Center(
                        child: Text(""),
                      )
                    : data['questions'][i]['selected_ans'] ==
                            data['questions'][i]['correct_ans']
                        ? Center(
                            child: Column(
                              children: [
                                Text(
                                  "\n😊",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: scrnheight * 0.035),
                                ),
                                Text(
                                  "Correct Answer",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: scrnheight * 0.02),
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Column(
                              children: [
                                Text(
                                  "\n😔",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: scrnheight * 0.035),
                                ),
                                Text(
                                  "Wrong Answer",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: scrnheight * 0.02),
                                ),
                                Text(
                                  "\nCorrect Answer is:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: scrnheight * 0.015),
                                ),
                                // Text(
                                //   "${data['questions'][i][(data['questions'][i]['correct_ans'])]}",
                                //   style: TextStyle(
                                //       color: Colors.white,
                                //       fontSize: scrnheight * 0.02),
                                // ),
                                FadeInImage(
                                  placeholder:
                                      const AssetImage('assets/load-image.png'),
                                  image: NetworkImage(
                                      "${data['questions'][i][(data['questions'][i]['correct_ans'])]}"),
                                  height: scrnwidth * 0.45,
                                ),
                              ],
                            ),
                          ),
              ],
            ),
          ),
        );
      } else {
        ContainerList.add(
          Container(
            margin: EdgeInsets.only(bottom: scrnheight * 0.055),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        data['questions'][i]["question"].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: scrnheight * 0.02,
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/load-image.png'),
                      image: NetworkImage("${data['questions'][i]['img_url']}"),
                      height: scrnwidth * 0.45,
                    ),
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (data['questions'][i]['selected_ans'] == null) {
                          setState(() {
                            data['questions'][i]['selected_ans'] = "ans1";
                          });
                        }
                        ansverdQList = createQList(data);
                        print(data['questions'][i]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            // color: Colors.white,
                            color: data['questions'][i]['selected_ans'] == null
                                ? Colors.white
                                : data['questions'][i]['selected_ans'] == "ans1"
                                    ? (data['questions'][i]['selected_ans'] ==
                                            data['questions'][i]['correct_ans']
                                        ? Colors.green
                                        : Colors.red)
                                    : Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            data['questions'][i]["ans1"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (data['questions'][i]['selected_ans'] == null) {
                          setState(() {
                            data['questions'][i]['selected_ans'] = "ans2";
                          });
                          ansverdQList = createQList(data);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            // color: Colors.white,
                            color: data['questions'][i]['selected_ans'] == null
                                ? Colors.white
                                : data['questions'][i]['selected_ans'] == "ans2"
                                    ? (data['questions'][i]['selected_ans'] ==
                                            data['questions'][i]['correct_ans']
                                        ? Colors.green
                                        : Colors.red)
                                    : Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            data['questions'][i]["ans2"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (data['questions'][i]['selected_ans'] == null) {
                          setState(() {
                            data['questions'][i]['selected_ans'] = "ans3";
                          });
                          ansverdQList = createQList(data);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            // color: Colors.white,
                            color: data['questions'][i]['selected_ans'] == null
                                ? Colors.white
                                : data['questions'][i]['selected_ans'] == "ans3"
                                    ? (data['questions'][i]['selected_ans'] ==
                                            data['questions'][i]['correct_ans']
                                        ? Colors.green
                                        : Colors.red)
                                    : Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            data['questions'][i]["ans3"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (data['questions'][i]['selected_ans'] == null) {
                          setState(() {
                            data['questions'][i]['selected_ans'] = "ans4";
                          });
                          ansverdQList = createQList(data);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            // color: Colors.white,
                            color: data['questions'][i]['selected_ans'] == null
                                ? Colors.white
                                : data['questions'][i]['selected_ans'] == "ans4"
                                    ? (data['questions'][i]['selected_ans'] ==
                                            data['questions'][i]['correct_ans']
                                        ? Colors.green
                                        : Colors.red)
                                    : Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            data['questions'][i]["ans4"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
                      ),
                    ),
                    data['questions'][i]['selected_ans'] == null
                        ? Center(
                            child: Text(""),
                          )
                        : data['questions'][i]['selected_ans'] ==
                                data['questions'][i]['correct_ans']
                            ? Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "\n😊",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: scrnheight * 0.035),
                                    ),
                                    Text(
                                      "Correct Answer",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: scrnheight * 0.02),
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "\n😔",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: scrnheight * 0.035),
                                    ),
                                    Text(
                                      "Wrong Answer",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: scrnheight * 0.02),
                                    ),
                                    Text(
                                      "\nCorrect Answer is:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: scrnheight * 0.015),
                                    ),
                                    Text(
                                      "${data['questions'][i][(data['questions'][i]['correct_ans'])]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: scrnheight * 0.02),
                                    ),
                                  ],
                                ),
                              ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    }
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestions(leval, num);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  int qid = 0;
  @override
  Widget build(BuildContext context) {
    int minutes = _seconds ~/ 60;
    int remainingSeconds = _seconds % 60;
    setState(() {
      scrnwidth = MediaQuery.of(context).size.width;
      scrnheight = MediaQuery.of(context).size.height;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(leval == 1
            ? "Easy Mode"
            : leval == 2
                ? "Medium Mode"
                : "Hard Mode"),
      ),
      body: SingleChildScrollView(
          child: loading
              ? Container(
                  alignment: Alignment.center,
                  height: scrnheight,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: scrnheight * 0.015),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Chip(
                              // elevation: 20,
                              padding: EdgeInsets.all(5),
                              backgroundColor: Colors.yellow,
                              shadowColor: Colors.black,
                              label: Text(
                                '${qid + 1} of ${ContainerList.length}',
                                style: TextStyle(
                                    fontSize: scrnwidth * 0.04,
                                    color: Colors.black),
                              ),
                            ),
                            Chip(
                              // elevation: 20,
                              padding: EdgeInsets.all(5),
                              backgroundColor:
                                  Color.fromARGB(255, 244, 54, 149),
                              shadowColor: Colors.black,
                              avatar: const Icon(
                                Icons.watch_later_outlined,
                                color: Colors.white,
                              ),
                              label: Text(
                                '$minutes:${remainingSeconds.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                    fontSize: scrnwidth * 0.04,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ContainerList[qid],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          qid != 0
                              ? ElevatedButton(
                                  child: Text('Back'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      fixedSize: Size(
                                          scrnwidth * 0.25, scrnheight * 0.05)),
                                  onPressed: () {
                                    if (qid != 0) {
                                      setState(() {
                                        qid--;
                                      });
                                    }
                                  },
                                )
                              : const Text(""),
                          qid < ContainerList.length - 1
                              ? ElevatedButton(
                                  child: Text('Next'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      fixedSize: Size(
                                          scrnwidth * 0.25, scrnheight * 0.05)),
                                  onPressed: () {
                                    if (qid < ContainerList.length - 1) {
                                      setState(() {
                                        qid++;
                                      });
                                    }
                                  },
                                )
                              : ElevatedButton(
                                  child: Text('Next'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      fixedSize: Size(
                                          scrnwidth * 0.25, scrnheight * 0.05)),
                                  onPressed: () {
                                    _timer.cancel();

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ScoreView(
                                                qDataList: ansverdQList,
                                                timeTacken: _seconds,
                                                num: num,
                                                leval: leval)));
                                  },
                                ),
                        ],
                      ),
                    ],
                  ),
                )),
    );
  }
}
