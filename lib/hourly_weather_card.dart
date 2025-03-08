import 'package:flutter/material.dart';

class HourlyWeatherCard extends StatelessWidget{
  final String time;
  final IconData icon;
  final double temp;
  const HourlyWeatherCard({super.key, required this.time, required this.icon, required this.temp});
  @override
  Widget build(BuildContext context){
    return Card(
    child: Container(
      padding: const EdgeInsets.all(10),
      width: 100,
      child: Column(children: [
        Text(time, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,),maxLines: 1, ),
        const SizedBox(height: 6,),
        Icon(icon, size: 32),  
        const SizedBox(height: 6,),
        Text("$temp°C", style: TextStyle(fontSize: 16),)
      ],),
    )
  );
  }
}