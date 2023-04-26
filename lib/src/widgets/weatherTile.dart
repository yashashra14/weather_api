import 'package:flutter/material.dart';

Widget weatherWidget(IconData icon, String temp, String location){
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Icon(
          icon,
          color: Colors.orange,
          size: 64.0,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "$temp C",
          style: const TextStyle(
            fontSize: 46,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          location,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[400],
          ),
        ),
      ],
    ),
  );
}