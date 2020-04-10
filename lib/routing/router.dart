import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../pages/loading.dart';
import '../pages/home.dart';
import '../pages/chooseLocation.dart';
import 'routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case LoadingRoute:
      return MaterialPageRoute(builder: (context) =>Loading());
    case HomeRoute:
      return MaterialPageRoute(builder: (context) =>Home());
    case LocationRoute:
      return MaterialPageRoute(builder: (context) =>ChooseLocation());
    default:
      return MaterialPageRoute(builder: (context) =>Home());
  }
}