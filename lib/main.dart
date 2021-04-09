import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> notes = [
    "C",
    "C#",
    "D",
    "Eb",
    "E",
    "F",
    "F#",
    "G",
    "G#",
    "A",
    "Bb",
    "B"
  ];
  num _angle = 0.0;
  Offset _touchPositionFromCenter;

  void _incrementCounter() {
    setState(() {
      _angle = _angle - pi / 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  Colors.blueAccent[100],
                  Colors.blueAccent[700],
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Transporte de Acordes"),
              SizedBox(height: 20),
              Stack(
                children: [
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.width * .8,
                      width: MediaQuery.of(context).size.width * .8,
                      child: LayoutBuilder(builder: (context, constraints) {
                        return GestureDetector(
                          onPanEnd: (details) {
                            final angleFinalPosition =
                                _touchPositionFromCenter.direction;
                            final angelFinalDivision =
                                (angleFinalPosition / (pi / 6));
                            setState(
                              () {
                                _angle = angelFinalDivision.round() * pi / 6;
                              },
                            );
                          },
                          onPanUpdate: (details) {
                            Offset centerOfGestureDetector = Offset(
                              constraints.maxWidth / 2,
                              constraints.maxHeight / 2,
                            );
                            final touchPositionFromCenter =
                                details.localPosition - centerOfGestureDetector;
                            setState(
                              () {
                                _touchPositionFromCenter =
                                    touchPositionFromCenter;
                                _angle = touchPositionFromCenter.direction;
                              },
                            );
                          },
                          child: Transform.rotate(
                            angle: _angle,
                            child: AnimatedContainer(
                              duration: Duration(seconds: 2),
                              height: MediaQuery.of(context).size.width * .8,
                              width: MediaQuery.of(context).size.width * .8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  // (
                                  //   begin: Alignment.topCenter,
                                  //   end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.blueAccent,
                                    Colors.blueAccent[700],
                                  ],
                                ),
                              ),
                              child: Stack(
                                children: [
                                  OutsiteNote(note: notes[0], angle: 0),
                                  OutsiteNote(note: notes[1], angle: 1),
                                  OutsiteNote(note: notes[2], angle: 2),
                                  OutsiteNote(note: notes[3], angle: 3),
                                  OutsiteNote(note: notes[4], angle: 4),
                                  OutsiteNote(note: notes[5], angle: 5),
                                  OutsiteNote(note: notes[6], angle: 6),
                                  OutsiteNote(note: notes[7], angle: 7),
                                  OutsiteNote(note: notes[8], angle: 8),
                                  OutsiteNote(note: notes[9], angle: 9),
                                  OutsiteNote(note: notes[10], angle: 10),
                                  OutsiteNote(note: notes[11], angle: 11),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * .15),
                      child: AnimatedContainer(
                        duration: Duration(seconds: 2),
                        height: MediaQuery.of(context).size.width * .5,
                        width: MediaQuery.of(context).size.width * .5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            InsideNote(note: notes[0], angle: 0),
                            InsideNote(note: notes[1], angle: 1),
                            InsideNote(note: notes[2], angle: 2),
                            InsideNote(note: notes[3], angle: 3),
                            InsideNote(note: notes[4], angle: 4),
                            InsideNote(note: notes[5], angle: 5),
                            InsideNote(note: notes[6], angle: 6),
                            InsideNote(note: notes[7], angle: 7),
                            InsideNote(note: notes[8], angle: 8),
                            InsideNote(note: notes[9], angle: 9),
                            InsideNote(note: notes[10], angle: 10),
                            InsideNote(note: notes[11], angle: 11),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class OutsiteNote extends StatelessWidget {
  const OutsiteNote({
    Key key,
    this.note,
    this.angle,
  }) : super(key: key);

  final String note;
  final int angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 6,
      child: Center(
        child: ClipPath(
          clipper: SegmentCustomClipper(),
          child: Container(
            height: MediaQuery.of(context).size.width * .8,
            width: (MediaQuery.of(context).size.width * .8) / 3.3333333,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.orange[200],
                  Colors.orange[900],
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text(
                  note,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SegmentCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    double radius = 18;

    path
      ..moveTo(0, radius)
      ..lineTo(centerX, centerY)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(centerX, 0, 0, radius);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class InnerSegmentCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    double radius = 11;

    path
      ..moveTo(0, radius)
      ..lineTo(centerX, centerY)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(centerX, 0, 0, radius);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class InsideNote extends StatelessWidget {
  const InsideNote({
    Key key,
    this.note,
    this.angle,
  }) : super(key: key);

  final String note;
  final int angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 6,
      child: Center(
        child: ClipPath(
          clipper: InnerSegmentCustomClipper(),
          child: Container(
            height: MediaQuery.of(context).size.width * .5,
            width: (MediaQuery.of(context).size.width * .5) / 3.3333333,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.blueAccent,
                  Colors.blueAccent[400],
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text(
                  note,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
