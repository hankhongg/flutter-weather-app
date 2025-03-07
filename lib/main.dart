import "package:flutter/material.dart";
import "./weather_screen.dart";

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  Widget build(BuildContext build){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true,),
      home: WeatherApp(),
    );
  }
}