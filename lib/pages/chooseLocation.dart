import 'package:flutter/material.dart';
import 'package:tutorial4/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png',),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    //navigate to home screen, pass back data, pop current screen off the stack
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDayTime,
    });
  }


  Future<WorldTime> createAlertDialog(BuildContext context){ //catches future quote
    TextEditingController countryController = new TextEditingController();
    TextEditingController continentController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(
                'Add New Time'
            ),
            content: Column(
              children: <Widget>[
                Text('Continent:',),
                TextField(
                  controller: continentController,
                ),
                Text('City:',),
                TextField(
                  controller: countryController,
                ),
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Submit'),
                onPressed: () {//closes popup and passes back worldTime object
                  String url = '${continentController.text}/${countryController.text}';
                  String location = '${countryController.text}';
                  String flag = 'night.jfif';
                  WorldTime instance = WorldTime(location: location, flag: flag, url: url);
                  Navigator.of(context).pop(instance);
                },
              ),
              MaterialButton(
                elevation: 5.0,
                child: Text('Cancel'),
                onPressed: () {

                  Navigator.of(context).pop(null);
                },
              ),
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Choose a location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 4),
            child: Card(
              child: ListTile(
                onTap: (){
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
        itemCount: locations.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          createAlertDialog(context).then((onValue){ //onValue catches quote
            setState(() {
              locations.add(onValue);
            });
          });
        },
        child: Text('Add'),
      ),
    );
  }
}
