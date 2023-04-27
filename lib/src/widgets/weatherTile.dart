import 'package:flutter/material.dart';

Widget weatherWidget(
    String icon, String weatherDesc, String temp, String location) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Image.network("https://openweathermap.org/img/wn/$icon@2x.png"),
        Text(
          weatherDesc,
          style: const TextStyle(
            color: Colors.white,
          ),
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
