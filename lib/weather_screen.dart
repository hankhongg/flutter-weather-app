import 'dart:convert';
import 'dart:ui';
import 'dart:core';
import 'package:weather_app/additional_card.dart';
import 'hourly_weather_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/SECRET_KEYS.dart';

class WeatherApp extends StatefulWidget{
  WeatherApp({super.key});
  _WeatherAppState createState() => _WeatherAppState();
}
class _WeatherAppState extends State<WeatherApp>{
  // do declare here

  /* ---purely optional

  double currTemp = double.infinity;
  bool isLoading = false;*/

  String convertToC(double k){
    return (k - 273.15).toStringAsFixed(2);
  }

  Future<Map<String, dynamic>> getCurrentWeather () async{
    try {
      // đang load
      /*isLoading = true;*/ // --- purely optional
      
      String cityName = "Ho%20Chi%20Minh%20City";
      final result = await http.get(
        Uri.parse('$BASE_URL?q=$cityName&APPID=$API_KEY'), // add the api url here
      );
      final data = jsonDecode(result.body);
      if (data['cod'] != '200'){
        throw "Something went wrong";
      }

      // setState(() { // ---purely optional
      //   currTemp = data['list'][0]['main']['temp'];
      //   // load xông gồi
      //   isLoading = false;
      // });

      //pls han hay return data..
      return data;
    } catch(e){
      throw "Something went wrong";
    }
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentWeather();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          // InkWell(
          //   onTap: () => print("Refresh"),
          //   child: Icon(Icons.refresh_rounded),
          // ),
          // GestureDetector(
          //   onTap:() => print("Refresh"),
          //   child: Icon(Icons.refresh_rounded),
          // )
          IconButton(icon: Icon(Icons.refresh_rounded), onPressed: ()=>{}),
        ]
      ),
      body: /*isLoading hoặc currTemp == double.infinity ? CircularProgressIndicator() : */ // ---purely optional we can use Future builder instead
      FutureBuilder(
        future: getCurrentWeather(),
        builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator.adaptive(),);
          }
          if (snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }
          if (snapshot.hasData == false){
            return const Center(child: Text("No data"),);
          }

          final data = snapshot.data!;
          var currentWeather = data['list'][0];

          double currTemp = currentWeather['main']['temp'];
          String currStatus = currentWeather['weather'][0]['main']; // Clouds or Rain or Sunny?
          final currHumidity = currentWeather['main']['humidity'];
          final currWindSpeed = currentWeather['wind']['speed'];
          final currPressure = currentWeather['main']['pressure'];


          return Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start, // can replace Align widget
            children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(children: [
                        Text("${(convertToC(currTemp).toString())}°C", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 16,),
                        Icon(currStatus == 'Clouds' ? Icons.cloud : currStatus == 'Rain' ? Icons.thunderstorm : Icons.sunny, size: 64),
                        const SizedBox(height: 16,),
                        Text(currStatus, style: TextStyle(fontSize: 20),),
                        const SizedBox(height: 6,)
                      ],),
                    )
                  ),
                )
              ),
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Weather Forecast", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
            ),
            const SizedBox(height: 12),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
              HourlyWeatherCard(time: "09:00", icon: Icons.sunny, temp: 30),
              HourlyWeatherCard(time: "12:00", icon: Icons.cloud, temp: 34),
              HourlyWeatherCard(time: "15:00", icon: Icons.cloud, temp: 28),
              HourlyWeatherCard(time: "18:00", icon: Icons.beach_access_sharp, temp: 21),
              HourlyWeatherCard(time: "21:00", icon: Icons.nightlight_round, temp: 23),
              ],),
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Additional Information", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              AddtionalCard(icon: Icons.water_drop, string: "Humidity", value: currHumidity.toInt()),
              AddtionalCard(icon: Icons.air, string: "Wind Speed", value: currWindSpeed.toInt()),
              AddtionalCard(icon: Icons.beach_access, string: "Pressure", value: currPressure.toInt()),
            ],),
          ],),
        );
      }),
    );
  }
}



