import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tutorial4/services/world_time.dart';
import 'loading.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png',),
  ];
  var _currentItemSelected = 'Select Location';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentItemSelected = (_currentItemSelected == 'Select Location') ? 'Select Location' : _currentItemSelected;

  }


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

  Future<WorldTime> createAlertDialog(BuildContext context) async{ //catches future quote

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(
                'Add New Time'
            ),
            content: Column(
              children: <Widget>[
                DropdownButton<String>(// so far unable to update
                  isExpanded: true,
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (newValue) {
                    setState(() {
                      _currentItemSelected = newValue;
                    });
                  },
                  items: urlData.map((dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  hint: Text('Select Location'),
                ),
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: (){
                  setState(() {
                    Navigator.of(context).pop(null);
                  });
                },
                child: Text(
                  "Cancel"
                ),
              )
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
      body: ListView.builder( // scrolling widget, builds children widgets from locations list data
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
          createAlertDialog(context).then((onValue){ //onValue catches Quote from the createAlertDialog function
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
