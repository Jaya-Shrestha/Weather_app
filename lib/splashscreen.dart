import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateHome();
  }

// Navigate to homepage after 5 seconds.
  navigateHome() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Container(
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Color.fromARGB(255, 124, 24, 255)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: Image.asset('assets/resize.png',
              // fit: BoxFit.fitWidth,
              fit: BoxFit.fill),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.cloudy_snowing,
              size: 80,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Weather",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "We show weather for you!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    fixedSize: const Size.fromWidth(100)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: const Text(
                  "Skip →",
                  style:
                      TextStyle(color: Colors.deepPurpleAccent, fontSize: 16),
                ),
              ),
            )),
      ],
    ));
  }
}
