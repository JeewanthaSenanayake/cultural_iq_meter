import 'dart:ui';

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
  Future getQuestions(int lvl, int number) async {
    final response = await http.get(Uri.parse(
        'https://cultural-iq-meter.onrender.com/iq_meter/api/v1/questions/get_questions/$lvl/$number'));

    if (response.statusCode == 200) {
      qData = json.decode(response.body);
      createQList(qData);
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
  void createQList(data) {
    for (var i = 0; i < data['questions'].length; i++) {
      data['questions'][i]['selected_ans'] = "";
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
                        qData['questions'][i]["question"].toString(),
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
                        data['questions'][i]['selected_ans'] = 1;
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            qData['questions'][i]["ans1"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        data['questions'][i]['selected_ans'] = 2;
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            qData['questions'][i]["ans2"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        data['questions'][i]['selected_ans'] = 3;
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            qData['questions'][i]["ans3"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        data['questions'][i]['selected_ans'] = "ans4";
                        print(data['questions'][i]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            qData['questions'][i]["ans4"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      } else if ((data['questions'][i]['img_url'].runtimeType).toString() ==
          'List<dynamic>') {
        print("List");
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
                        qData['questions'][i]["question"].toString(),
                        style: TextStyle(
                            color: Colors.white, fontSize: scrnheight * 0.02),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/load-image.png'),
                      image:
                          NetworkImage("${qData['questions'][i]['img_url']}"),
                      height: scrnwidth * 0.45,
                    ),
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            qData['questions'][i]["ans1"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            qData['questions'][i]["ans2"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            qData['questions'][i]["ans3"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        width: scrnwidth * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            qData['questions'][i]["ans4"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: scrnheight * 0.02),
                          ),
                        ),
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestions(leval, num);
  }

  int qid = 0;
  @override
  Widget build(BuildContext context) {
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
                      ContainerList[qid],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            child: Text('Back'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              if (qid != 0) {
                                setState(() {
                                  qid--;
                                });
                              }
                            },
                          ),
                          ElevatedButton(
                            child: Text('Next'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              if (qid < ContainerList.length - 1) {
                                setState(() {
                                  qid++;
                                });
                              }
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
