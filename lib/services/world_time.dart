import 'package:intl/intl.dart';

import 'package:http/http.dart';
import 'dart:convert';

class WorldTime{
  String location; // location name for UI
  String time; // time in that location
  String flag; // url to asset flag icon
  String url; // location url for api endpoints
  bool isDayTime; // true/false if day/not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try{
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);


      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print('error caught: $e');
      time = 'could not retrieve data. Error: $e';
    }


  }


}