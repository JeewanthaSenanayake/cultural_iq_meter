import 'package:cultural_iq_meter/Pages/MainMenu.dart';
import 'package:flutter/material.dart';

class GetStart extends StatefulWidget {
  const GetStart({super.key});

  @override
  State<GetStart> createState() => _GetStartState();
}

class _GetStartState extends State<GetStart> {
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
          image: AssetImage('assets/bg.jpg'), // Replace with your own image
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: scrnheight * 0.2),
              child: Text(
                'Cultural\n\t\t\t\t\tIQ\n\t\tMeter',
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 5
                    ..color = Colors.blue,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(3.0, 3.0),
                      blurRadius: 3.0,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ],
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: scrnheight * 0.125),
              child: ElevatedButton(
                child: Text(
                  'Get Start',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5)),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MainMenu()));
                },
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
