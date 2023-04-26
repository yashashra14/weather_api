import 'package:flutter/material.dart';
import '../services/weather_api_service.dart';
import '../model/weather_model.dart';
import '../widgets/weatherTile.dart';
import '../widgets/additional_info.dart';

class Weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeatherState();
}

class WeatherState extends State<Weather> {
  String city = "Mumbai";
  WeatherApiClient client = WeatherApiClient();
  WeatherModel? model;

  Future<WeatherModel?> getData() async {
    model = await client.getCurrentWeather(city);
    return model;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          leading: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
          title: Center(child: Text(city)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.indigo,
          ),
          child: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot<WeatherModel?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.data;
                  final temp = data!.temp! - 273.15; // to Celcius
                  final feels_like = data!.feels_like! - 273.15; // to Celcius
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      weatherWidget(
                        Icons.wb_sunny_rounded,
                        temp.toStringAsFixed(1),
                        data.cityName!,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      const Text(
                        "Additional Information",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 20,
                      ),
                      additionalInfo(
                        data.wind.toString(),
                        data.humidity.toString(),
                        feels_like.toStringAsFixed(1),
                        data.pressure.toString(),
                      ),
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
