// class WeatherModel {
//   WeatherModel({required, this.currentWeather});
//   // ignore: prefer_typing_uninitialized_variables
//   final currentWeather;

//   factory WeatherModel.fromJson(Map<String, dynamic> data) {
//     final currentWeather = data["current WEATHER"] as Map<String, dynamic>;
//     return WeatherModel(currentWeather: currentWeather);
//   }
// }

// class CurrentWeather {
//   CurrentWeather({
//     required this.temp_c,
//     required this.temp_f,
//   });

//   final double temp_c;
//   final double temp_f;

//   factory CurrentWeather.fromJson(Map<String, dynamic> data) {
//     final tempC = data['tempCelsius'] as double;
//     final tempF = data['tempFarenhiet'] as double;
//     return CurrentWeather(temp_c: tempC, temp_f: tempF);
//   }
// }
