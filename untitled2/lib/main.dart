import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:untitled2/pages/rebanho.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xB30D4235),
        automaticallyImplyLeading: false,

        title: Align(
          alignment: AlignmentDirectional(0, -0.05),
          child: Text(
            'Grex-Bov',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (

                  ){

                Navigator.push(context, MaterialPageRoute(builder: (context) => Rebanho()));
              },
              style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF098799),
                  fixedSize: const Size(350, 80),
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24))),
              child: const Text(
                'REBANHO',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),

            ),
            SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: null,
              style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF098799),
                  fixedSize: const Size(350, 80),
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24))),
              child: const Text(
                'RESFRIADOR',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
