class WeatherModel {
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  double? feels_like;
  int? pressure;
  String? icon;
  String? weatherDesc;

  WeatherModel({
    this.cityName,
    this.temp,
    this.wind,
    this.humidity,
    this.feels_like,
    this.pressure,
    this.icon,
    this.weatherDesc,
  });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    temp = json["main"]["temp"];
    wind = json["wind"]["speed"];
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];
    feels_like = json["main"]["feels_like"];
    icon = json["weather"][0]["icon"];
    weatherDesc = json["weather"][0]["main"];
  }
  @override
  String toString() {
    // TODO: implement toString
    return """
      $cityName
      $temp
      $wind
      $pressure
      $humidity
      $feels_like
      $icon
    """;
  }
}
