import 'package:cultural_iq_meter/Pages/QuestionPage.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  dynamic userData;
  MainMenu({super.key, required this.userData});

  @override
  State<MainMenu> createState() => _MainMenuState(userData);
}

class _MainMenuState extends State<MainMenu> {
  dynamic userData;
  _MainMenuState(this.userData);
  @override
  Widget build(BuildContext context) {
    double scrnwidth = MediaQuery.of(context).size.width;
    double scrnheight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("IQ Meater"),
      // ),
      body: SingleChildScrollView(
        child: Container(
          height: scrnheight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage('assets/bg2.jpg'), // Replace with your own image
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: scrnheight * 0.05,
                    right: scrnheight * 0.05,
                    top: scrnheight * 0.17),
                child: GestureDetector(
                  onTap: () async {
                    print("Easy");

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuestionPage(
                              leval: 1,
                              num: 10,
                              userData: userData,
                            )));
                  },
                  child: Container(
                    height: scrnheight * 0.2,
                    width: scrnwidth * 0.75,
                    color: Color.fromARGB(175, 56, 238, 39),
                    child: Center(
                      child: Text(
                        "Easy",
                        style: TextStyle(fontSize: scrnwidth * 0.15),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: scrnheight * 0.05,
                    right: scrnheight * 0.05,
                    top: scrnheight * 0.05),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuestionPage(
                              leval: 2,
                              num: 10,
                              userData: userData,
                            )));
                  },
                  child: Container(
                    height: scrnheight * 0.2,
                    width: scrnwidth * 0.75,
                    color: Color.fromARGB(175, 235, 238, 39),
                    child: Center(
                      child: Text(
                        "Medium",
                        style: TextStyle(fontSize: scrnwidth * 0.15),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: scrnheight * 0.05,
                    right: scrnheight * 0.05,
                    top: scrnheight * 0.05),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuestionPage(
                              leval: 3,
                              num: 10,
                              userData: userData,
                            )));
                  },
                  child: Container(
                    height: scrnheight * 0.2,
                    width: scrnwidth * 0.75,
                    color: Color.fromARGB(175, 238, 39, 39),
                    child: Center(
                      child: Text(
                        "Hard",
                        style: TextStyle(fontSize: scrnwidth * 0.15),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
