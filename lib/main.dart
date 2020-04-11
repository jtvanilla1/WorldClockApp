import 'package:flutter/material.dart';

import 'package:tutorial4/routing/routing_constants.dart';
import 'routing/router.dart' as router;

void main() => runApp(WorldClockApp());

class WorldClockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Clock App',
      onGenerateRoute: router.generateRoute,
      initialRoute: LoadingRoute,
    );
  }
}
