import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Icon icon;
  final String data;
  final String data1;

  const MyCard(
      {super.key, required this.icon, required this.data1, required this.data});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      direction: Axis.horizontal,
      children: [
        Container(
          height: 150,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3366FF),
                    Color(0xFF00CCFF),
                  ],
                  // begin: FractionalOffset(0.0, 0.0),
                  // end: FractionalOffset(1.0, 0.0),
                  // stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              border: Border.all(
                color: Colors.blueAccent,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  data,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                icon,
                Text(
                  data1,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ResultText extends StatelessWidget {
  final String data2;
  const ResultText({super.key, required this.data2});

  @override
  Widget build(BuildContext context) {
    return Text(
      data2,
      style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
          color: Colors.blueAccent),
      textAlign: TextAlign.center,
    );
  }
}

class AllText extends StatelessWidget {
  final String data3;

  const AllText({super.key, required this.data3});

  @override
  Widget build(BuildContext context) {
    return Text(
      data3,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Nunito',
        color: Colors.blueAccent,
      ),
      textAlign: TextAlign.center,
    );
  }
}
