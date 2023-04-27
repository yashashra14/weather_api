import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/src/services/geolocation_service.dart';
import '../services/weather_api_service.dart';
import '../model/weather_model.dart';
import '../widgets/weatherTile.dart';
import '../widgets/additional_info.dart';
import 'package:geolocator/geolocator.dart';

class Weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeatherState();
}

class WeatherState extends State<Weather> {
  bool yourLocation = true;
  String city = "Your Location";
  WeatherApiClient client = WeatherApiClient();
  WeatherModel? model;
  List<String> cityList = [
    'Your Location',
    'Mumbai',
    'Delhi',
    'Calcutta',
    'Chennai'
  ];

  //gps variables
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  Future<WeatherModel?> getDataUsingCity() async {
    model = await client.getCurrentWeatherUsingCity(city);
    return model;
  }

  Future<WeatherModel?> getDataUsingLat() async {
    model = await client.getCuurrentWeatherUsingLocation(
        double.tryParse(lat), double.tryParse(long));
    return model;
  }

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  checkGps() async {
    GeoLocatorService service = GeoLocatorService();
    Position? position = await service.checkGps();

    setState(() {
      long = position!.longitude.toString();
      lat = position.latitude.toString();
    });
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
            DropdownButton(
              iconEnabledColor: Colors.white,
              dropdownColor: Colors.indigo,
              value: city,
              items: cityList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(
                () {
                  city = value!;
                  yourLocation = value == 'Your Location';
                },
              ),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.indigo,
          ),
          child: FutureBuilder(
            future: yourLocation ? getDataUsingLat() : getDataUsingCity(),
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
                  final feels_like = data.feels_like! - 273.15; // to Celcius

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      weatherWidget(
                        data.icon!,
                        data.weatherDesc!,
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
