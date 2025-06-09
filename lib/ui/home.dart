import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_with_api_flutter/service/api_service.dart';
import 'package:weather_app_with_api_flutter/widget/future_weather_list_item.dart';
import '../model/WeatherModel.dart';
import '../widget/hourly_weather_list.dart';
import '../widget/today_weather.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiService apiService = ApiService();
  final serachEditText = TextEditingController();
  String searchText = "auto:ip";

  Future<String?> _showTextInputDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.grey[900],
          title: const Text(
            "🔍 Search Location",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          content: TextFormField(
            controller: serachEditText,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter city, zip, lat, lon",
              hintStyle: TextStyle(color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.grey[800],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.location_on, color: Colors.white),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.cancel, color: Colors.white),
              label: const Text("Cancel"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (serachEditText.text.trim().isEmpty) return;
                Navigator.pop(context, serachEditText.text.trim());
              },
              icon: const Icon(Icons.check_circle, color: Colors.white),
              label: const Text("OK"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          "Weather App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              serachEditText.clear();
              String? text = await _showTextInputDialog(context);
              if (text != null && text.isNotEmpty) {
                setState(() {
                  searchText = text;
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              setState(() {
                searchText = "auto:ip";
              });
            },
          ),
        ],
      ),
      
      
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder(
          future: apiService.getWeatherData(searchText),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            print("Fetched days: ${snapshot.data?.forecast?.forecastday?.length}");

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "❌ Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            WeatherModel? weatherModel = snapshot.data;
            return SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  TodayWeather(weatherModel: weatherModel),
                  const SizedBox(height: 10),
                  const Text(
                    "Weather By Hours",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: weatherModel?.forecast?.forecastday?[0].hour?.length ?? 0,
                      itemBuilder: (context, index) {
                        Hour? hour = weatherModel?.forecast?.forecastday?[0].hour?[index];
                        return HourlyWeatherListItem(hour: hour);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Next 3 Days Weather",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: weatherModel?.forecast?.forecastday?.length ?? 0,
                      itemBuilder: (context, index) {
                        Forecastday? forecastday = weatherModel?.forecast?.forecastday?[index];
                        return FutureWeatherListItem(forcastday: forecastday);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
