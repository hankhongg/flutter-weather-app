import "package:flutter/material.dart";

class AddtionalCard extends StatelessWidget{
  // required final things!
  final IconData icon;
  final String string;
  final double value;
  // constructor
  const AddtionalCard({super.key, required this.icon, required this.string, required this.value});

  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(12),
      width: 115,
      child: Column(children: [
        Icon(icon, size: 32,),
        const SizedBox(height: 6,),
        Text(string, style: TextStyle(fontSize: 16),),
        Text(value.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
      ],),
    );
  }
}