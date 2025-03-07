import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherApp extends StatefulWidget{
  WeatherApp({super.key});
  _WeatherAppState createState() => _WeatherAppState();
}
class _WeatherAppState extends State<WeatherApp>{
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
      body: Padding(
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
                      Text("32°C", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 16,),
                      Icon(Icons.cloud, size: 64),
                      const SizedBox(height: 16,),
                      Text("Rain", style: TextStyle(fontSize: 20),),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
            HourlyWeatherCard(),
            HourlyWeatherCard(),
            HourlyWeatherCard(),
            HourlyWeatherCard(),
            HourlyWeatherCard(),
            ],),
          ),
          Placeholder(
            fallbackHeight: 150,
            fallbackWidth: 200,
          ),
          const SizedBox(height: 20),
          Placeholder(
            fallbackHeight: 150,
            fallbackWidth: 200,
          ),
        ],),
      )
    );
  }
}

class HourlyWeatherCard extends StatelessWidget{
  const HourlyWeatherCard({super.key});
  Widget build(BuildContext context){
    return Card(
    child: Container(
      padding: const EdgeInsets.all(10),
      width: 100,
      child: Column(children: [
        Text("09:00", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,), ),
        const SizedBox(height: 6,),
        Icon(Icons.cloud, size: 32),  
        const SizedBox(height: 6,),
        Text("32°C", style: TextStyle(fontSize: 16),)
      ],),
    )
  );
  }
}