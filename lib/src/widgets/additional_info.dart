import 'package:flutter/material.dart';

Widget additionalInfo(String wind, String humidity, String feels_like, String pressure){
  TextStyle titleFont = const TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color: Colors.white,);
  TextStyle infoFont = const TextStyle(fontWeight: FontWeight.w400, fontSize: 18,color: Colors.white,);
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Wind",
                  style: titleFont,
                ),
                const SizedBox(height: 18),
                Text(
                  "Pressure",
                  style: titleFont,
                ),
                const SizedBox(height: 18),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$wind m/s",
                  style: infoFont,
                ),
                const SizedBox(height: 18),
                Text(
                  "$pressure hPa",
                  style: infoFont,
                ),
                const SizedBox(height: 18),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Humidity",
                  style: titleFont,
                ),
                const SizedBox(height: 18),
                Text(
                  "Feels Like",
                  style: titleFont,
                ),
                const SizedBox(height: 18),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$humidity %",
                  style: infoFont,
                ),
                const SizedBox(height: 18),
                Text(
                  "$feels_like C",
                  style: titleFont,
                ),
                const SizedBox(height: 18),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}