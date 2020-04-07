import 'package:flutter/material.dart';

import 'package:tutorial4/pages/home.dart';
import 'package:tutorial4/pages/chooseLocation.dart';
import 'package:tutorial4/pages/loading.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    //think about route paths, and how pages stack on top of each other with routing
    //think about push/pop in route stacks
    //--initState(), Build(), Dispose()
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/location': (context) => ChooseLocation(),
  },
));

