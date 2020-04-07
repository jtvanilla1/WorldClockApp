import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data ={};

  @override
  Widget build(BuildContext context) {

   data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments; //don't update if data already passed back from location page
   print(data);

   //set background
   String bgImage= data['isDaytime'] ? 'day.jpg' : 'night.jfif';
   Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo;
   Color textColor = data['isDaytime'] ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Column(
                children: <Widget>[
                  FlatButton.icon(onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag'],
                      };
                    });
                  }, icon: Icon(Icons.edit_location, color: textColor,), label: Text('Edit Location, UwU', style:
                    TextStyle(
                      color: textColor,
                    ),)),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(data['location'],
                        style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 2,
                        color: textColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66,
                      color: textColor,
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
