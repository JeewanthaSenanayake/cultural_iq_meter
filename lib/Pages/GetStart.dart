import 'package:cultural_iq_meter/Pages/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class GetStart extends StatefulWidget {
  const GetStart({super.key});

  @override
  State<GetStart> createState() => _GetStartState();
}

class _GetStartState extends State<GetStart> {
  TextEditingController _textController = TextEditingController();
  bool _isLoading = false;
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
            Center(
              child: Padding(
                padding: EdgeInsets.all(scrnheight * 0.04),
                child: TextField(
                  controller: _textController,
                  style: const TextStyle(
                    // Set the text color of the user input
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors
                              .blue, // Replace with your desired border color
                          width: 4.0,
                        ),
                      ),
                      labelText: 'User Name',
                      labelStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      hintText: 'Enter Your Name',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: scrnheight * 0.03),
              child: ElevatedButton(
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Get Start',
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5)),
                onPressed: () async {
                  if (_textController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("User name can't be empty"),
                    ));
                  } else {
                    setState(() {
                      _isLoading = true;
                    });

                    final response = await http.put(Uri.parse(
                        'https://cultural-iq-meter.onrender.com/iq_meter/api/v1/users/add_user/${_textController.text}'));
                    print(response.statusCode);
                    if (response.statusCode == 200) {
                      setState(() {
                        _isLoading = false;
                      });
                      dynamic userData = jsonDecode(response.body);
                      print(userData);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MainMenu(
                                userData: userData["user"],
                              )));
                    } else {
                      setState(() {
                        _isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "This username is allready taken, try another"),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
