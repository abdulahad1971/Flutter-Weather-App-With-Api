import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import '../model/WeatherModel.dart';

class TodayWeather extends StatelessWidget {
  final WeatherModel? weatherModel;

  const TodayWeather({super.key, this.weatherModel});

  WeatherType getWeatherType(Current? current) {
    final condition = current?.condition?.text?.toLowerCase() ?? '';
    final isDay = current?.isDay == 1;

    if (condition.contains("sunny")) {
      return WeatherType.sunny;
    } else if (condition.contains("clear")) {
      return isDay ? WeatherType.sunny : WeatherType.sunnyNight;
    } else if (condition.contains("partly cloudy")) {
      return isDay ? WeatherType.cloudy : WeatherType.cloudyNight;
    } else if (condition.contains("cloudy") || condition.contains("overcast")) {
      return isDay ? WeatherType.overcast : WeatherType.cloudyNight;
    } else if (condition.contains("thunder")) {
      return WeatherType.thunder;
    } else if (condition.contains("rain")) {
      return WeatherType.heavyRainy;
    } else if (condition.contains("shower")) {
      return WeatherType.middleSnow;
    } else {
      return isDay ? WeatherType.sunny : WeatherType.sunnyNight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = weatherModel?.current;
    final location = weatherModel?.location;
    final weatherType = getWeatherType(current);

    return Stack(
      children: [
        WeatherBg(
          weatherType: weatherType,
          width: MediaQuery.of(context).size.width,
          height: 300,
        ),
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      location?.name ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      current?.lastUpdated != null
                          ? DateFormat.yMMMMEEEEd()
                          .format(DateTime.parse(current!.lastUpdated!))
                          : "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 15),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10,
                    ),
                    child: Image.network(
                      "https:${current?.condition?.icon ?? ""}",
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.wb_cloudy, color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${current?.tempC?.round() ?? ''}",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              "°",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        current?.condition?.text ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 15),
                ],
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _weatherInfoColumn("Feels Like", "${current?.feelslikeC?.round() ?? ''}°"),
                        _weatherInfoColumn("Wind", "${current?.windKph?.round() ?? ''} km/h"),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _weatherInfoColumn("Humidity", "${current?.humidity ?? ''}%"),
                        _weatherInfoColumn("Visibility", "${current?.visKm?.round() ?? ''} km"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _weatherInfoColumn(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 15,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
