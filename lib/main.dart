import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Pomodoro(),
    ));

class Pomodoro extends StatefulWidget {
  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  double percent = 0;
  static int TimeInMinut = 25;
  int TimeInSec = TimeInMinut * 60;

  late Timer timer;

  _StartTimer() {
    TimeInMinut = 25;
    Duration(minutes: 25);
    int Time = TimeInMinut * 60;
    double SecPercent = (Time / 100);
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(
          () {
            if (Time > 0) {
              Time--;
              if (Time % 60 == 0) {
                TimeInMinut--;
              }
              if (Time % SecPercent == 0) {
                if (percent < 1) {
                  percent += 0.01;
                } else {
                  percent = 1;
                }
              }
            } else {
              percent = 0;
              timer.cancel();
              var timeInMinut = TimeInMinut;
              return;
            }
          },
        );
      },
    );
  }

  _StopTimer() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff1542bf), Color(0xff51a8ff)],
              begin: FractionalOffset(0.5, 1))),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Text(
              "Pomodoro",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontFamily: 'IndieFlower'),
            ),
          ),
          Expanded(
            child: CircularPercentIndicator(
              circularStrokeCap: CircularStrokeCap.round,
              percent: percent,
              animation: true,
              animateFromLastPercent: true,
              radius: 250.0,
              lineWidth: 20.0,
              progressColor: Colors.white,
              center: Text(
                "$TimeInMinut",
                style: TextStyle(color: Colors.white, fontSize: 80.0),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0)),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Estudo",
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontFamily: 'IndieFlower'),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "25",
                                  style: TextStyle(
                                      fontSize: 80.0,
                                      fontFamily: 'IndieFlower'),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Pausa",
                                  style: TextStyle(
                                      fontFamily: 'SourceCodePro',
                                      fontSize: 30.0),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "5",
                                  style: TextStyle(
                                      fontSize: 80.0,
                                      fontFamily: 'IndieFlower'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 28.0),
                      child: RaisedButton(
                        onPressed: _StartTimer,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "Come??ar estudo",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontFamily: 'IndieFlower'),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    )));
  }
}
