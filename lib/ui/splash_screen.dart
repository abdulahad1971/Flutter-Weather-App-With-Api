import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_with_api_flutter/ui/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Discover The\nWeather In Your City",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    fontSize: 32,
                  ),
                ),
              ),

              Spacer(),
              Image.asset("assets/logo/cloudy.png", height: 350),
              Spacer(),
              Center(
                child: Text(
                  "Get to know your weather maps and\nradar recipitations forcast",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                    child: Text("Get Started",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                    )
                    ,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
