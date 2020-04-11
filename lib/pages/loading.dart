import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

import 'package:tutorial4/routing/routing_constants.dart';
import 'package:tutorial4/services/world_time.dart';

//overhead variables
List<String> urlData = [];

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  Future<void> getUrls() async{
    Response response = await get('http://worldtimeapi.org/api/timezone/');
    urlData = jsonDecode(response.body).cast<String>();

  }

  void setupWorldTime() async { //default home settings, route to home
    WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');

    await instance.getTime();

    print('loading done, passing ${instance.location} to $HomeRoute from $context');
    Navigator.pushReplacementNamed(context, '/home', arguments: { //pass map to HomeRoute
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDayTime,

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUrls();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 80,
        ),
      ),
    );
  }
}