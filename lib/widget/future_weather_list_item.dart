import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/WeatherModel.dart';

class FutureWeatherListItem extends StatelessWidget {
  final Forecastday? forcastday;
  const FutureWeatherListItem({super.key, this.forcastday});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),

      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(8),
      width: double.infinity,
      child: Row(
        children: [
          Image.network("https:${forcastday?.day?.condition?.icon ?? ""}"),
          SizedBox(width: 8,),
          Expanded(child: Text(DateFormat.MMMEd().format(DateTime.parse(forcastday?.date.toString() ?? "")),style: TextStyle(color: Colors.white),)),
          Expanded(child: Text(forcastday?.day?.condition?.text.toString()??"",style: TextStyle(color: Colors.white),)),
          Expanded(child: Text(
            "^${forcastday?.day?.maxtempC?.round()}/${forcastday?.day?.mintempC?.round()}",
            style: TextStyle(color: Colors.white,fontSize: 18),
            )),

        ],
      ),
    );
  }
}
