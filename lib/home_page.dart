// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hide = false;
  double money = 50000.0;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    startTimer();
    startRandomizer();
  }

  void startRandomizer() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        meterValue = random.nextDouble() *
            100.0; // Randomly update the meter value between 0 and 100
      });
    });
  }

  String greeting = 'Day';
  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour >= 0 && hour < 12) {
      setState(() {});
      return greeting = 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      setState(() {});
      return greeting = 'Good Afternoon';
    } else {
      setState(() {});
      return greeting = 'Good Evening';
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 8), (timer) {
      setState(() {
        if (money >= 2) {
          money -= 2;
        } else {
          money = 0;
          timer.cancel(); // Stop the timer when money reaches zero
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  String formatMoney(double amount) {
    final formatter = NumberFormat("#,##0.00",
        "en_US"); // Use en_US locale for comma as a thousands separator
    return formatter.format(amount);
  }

  double meterValue = 6000.0; // Initial meter value

  final Random random = Random();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getGreeting();
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('POWER METER'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(height: 3 * size.height / 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundImage: AssetImage('assets/person.png'),
                      foregroundImage: AssetImage('assets/she.jpg'),
                    ),
                    SizedBox(width: 6),
                    Text(
                      '$greeting, Emmanuel',
                      style: GoogleFonts.acme(
                        textStyle: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      '20.35/KWh',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.yellow),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.emoji_objects,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 10 * size.width / 100),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Let\'s monitor your power consumption',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8 * size.height / 100),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Account Balance',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/naira.svg',
                      color: Colors.white,
                      height: 10,
                      width: 10,
                    ),
                    SizedBox(width: 2),
                    hide
                        ? Text(
                            '********',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          )
                        : Text(
                            '${formatMoney(money)}',
                            style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          hide = !hide;
                        });
                      },
                      child: Icon(
                        hide ? Icons.visibility_off : Icons.remove_red_eye,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 6 * size.height / 100),
            Container(
              height: 28 * size.height / 100,
              width: 60 * size.width / 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.yellow),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.purple,
                    elevation: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.outlet,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3 * size.height / 100),
                  Text(
                    '${meterValue.toStringAsFixed(2)}/KWH',
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 5 * size.height / 100),
                ],
              ),
            ),
            SizedBox(height: 6 * size.height / 100),
            Container(
              height: 15 * size.height / 100,
              width: 90 * size.width / 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
              ),
              child: Container(
                width: 100 * size.width / 100,
                height: 14 * size.height / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade600,
                      Colors.white,
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'IDAN  Savings Plan',
                              style: GoogleFonts.acme(
                                textStyle: TextStyle(
                                  color: Color.fromARGB(255, 20, 20, 29),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1 * size.height / 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image(
                                height: 7 * size.height / 100,
                                image: AssetImage('assets/micky.png'),
                              ),
                              SizedBox(width: 3 * size.width / 100),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Earn up to ',
                                        style: GoogleFonts.abel(
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '23% ',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.green.shade700,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'ROI with',
                                        style: GoogleFonts.abel(
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Our BIGI Savings Plan',
                                    style: GoogleFonts.abel(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.green.shade700,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5 * size.width / 100,
                                vertical: 2 * size.width / 100,
                              ),
                              child: Center(
                                child: Text(
                                  'Go',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
