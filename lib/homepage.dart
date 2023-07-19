import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/splashscreen.dart';
import 'package:weather_app/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String location = '',
      weatherData = '',
      locationData = '',
      cloud = '',
      wind = '',
      humidity = '',
      icons = '';

// Saving loaction for next launch
  void saveLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('location', location);
  }

// Get Current location
  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (permission != LocationPermission.denied) {
      getWeatherData(position.latitude, position.longitude);
    }
  }

// Get weather information of current location
  void getWeatherData(double latitude, double longitude) async {
    String url =
        'http://api.weatherapi.com/v1/current.json?key=122f3d42cd4342ad8a242636231707&q=$latitude,$longitude';
    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      final parsedData = jsonDecode(response.toString());
      // print(parsedData);
// API response for Display
      setState(() {
        locationData =
            '${parsedData['location']['name']},${parsedData['location']['country']}\n${parsedData['current']['condition']['text']}\nLast updated: ${parsedData['current']['last_updated']}';
        weatherData = '${parsedData['current']['temp_c']}°C';
        cloud = '${parsedData['current']['cloud']}';
        humidity = '${parsedData['current']['humidity']}';
        wind = '${parsedData['current']['wind_mph']}';
        icons = 'https:${parsedData['current']['condition']['icon']}';
      });
    } else {
      setState(() {
        weatherData = 'Failed to fetch weather data';
      });
    }
  }

// Get weather information of Required location
  void getWeatherByLocation() async {
    String url =
        'http://api.weatherapi.com/v1/current.json?key=122f3d42cd4342ad8a242636231707&q=$location&aqi=yes';
    Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      final parsedData = jsonDecode(response.toString());
      // print(parsedData);
      setState(() {
        locationData =
            '${parsedData['location']['name']},${parsedData['location']['country']}\n${parsedData['current']['condition']['text']}\nLast updated: ${parsedData['current']['last_updated']}';
        weatherData = '${parsedData['current']['temp_c']}°C';
        cloud = '${parsedData['current']['cloud']}';
        humidity = '${parsedData['current']['humidity']}';
        wind = '${parsedData['current']['wind_mph']}';
        icons = 'https:${parsedData['current']['condition']['icon']}';
      });
    } else {
      setState(() {
        weatherData = 'Failed to fetch weather data';
      });
    }
  }

// Skip/Update button label
  String getButtonLabel() {
    return location.isEmpty ? 'Save' : 'Update';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(title: Text("WeatherApp"),actions: [],),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 325,
                decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 300, top: 20),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SplashScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward),
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 90, top: 20),
                      child: const Text(
                        "Namaste,\nWelcome On Board",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          location = value;
                        });
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search Location',
                        prefixIcon: Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.blueGrey,
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 250),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            fixedSize: const Size.fromWidth(100)),
                        onPressed: () {
                          if (location.isNotEmpty) {
                            getWeatherByLocation();
                            saveLocation();
                          } else {
                            getLocation();
                          }
                        },
                        child: Text(
                          getButtonLabel(),
                          style: const TextStyle(
                              color: Colors.blueAccent, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const AllText(
                        data3: "Weather Update",
                      ),
                      // const Text(
                      //   "Weather Update",
                      //   style: TextStyle(
                      //       fontSize: 24,
                      //       fontWeight: FontWeight.bold,
                      //       // fontFamily: 'Times New Roman',
                      //       color: Colors.blueAccent),
                      //   textAlign: TextAlign.center,
                      // ),
                      const SizedBox(height: 20.0),
                      Column(
                        children: [
                          icons.isNotEmpty
                              ? Image.network(
                                  icons,
                                  width: 60.0,
                                  height: 60.0,
                                  color: (Colors.yellow[600])!,
                                )
                              : Container(),
                          ResultText(
                            data2: weatherData,
                          ),
                          ResultText(data2: locationData),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              MyCard(
                                icon: Icon(
                                  Icons.cloud,
                                  size: 50,
                                  color: ((Colors.yellow[600])!),
                                ),
                                data: "Cloud",
                                data1: cloud,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              MyCard(
                                icon: Icon(
                                  Icons.water_drop,
                                  color: (Colors.yellow[600])!,
                                  size: 50,
                                ),
                                data: "Humidity",
                                data1: humidity,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              MyCard(
                                icon: Icon(
                                  Icons.storm,
                                  color: (Colors.yellow[600])!,
                                  size: 50,
                                ),
                                data: "Wind",
                                data1: wind,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
