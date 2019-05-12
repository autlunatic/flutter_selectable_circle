import 'package:flutter/material.dart';
import 'package:selectable_circle/selectable_circle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "selectable_circle",
        home: MyHome(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ));
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool _isSelected = false;
  bool _isSelected2 = false;
  bool _isSelected3 = false;
  bool _isSelected4 = false;
  bool _isSelected5 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("example circle"),
      ),
      body: Column(
        children: <Widget>[
          Center(
              child: Text(
            "default",
            style: TextStyle(fontSize: 20.0),
          )),
          Center(
            child: SelectableCircle(
              width: 80.0,
              isSelected: _isSelected,
              onTap: () {
                setState(() {
                  _isSelected = !_isSelected;
                });
              },
              child: Text("test"),
            ),
          ),
          Center(
            child: Text(
              "Custom Colors",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Center(
            child: SelectableCircle(
              width: 80.0,
              isSelected: _isSelected2,
              color: Colors.brown,
              selectedBorderColor: Colors.orange,
              selectedColor: Colors.tealAccent,
              selectMode: SelectMode.simple,
              onTap: () {
                setState(() {
                  _isSelected2 = !_isSelected2;
                });
              },
              child: Icon(Icons.star),
            ),
          ),
          Center(
              child: Text(
            "empty Circle custom colors",
            style: TextStyle(fontSize: 20.0),
          )),
          Center(
            child: SelectableCircle(
              isSelected: _isSelected3,
              borderColor: Colors.greenAccent,
              selectedColor: Colors.blue,
              selectedBorderColor: Colors.red[900],
              width: 80.0,
              onTap: () {
                setState(() {
                  _isSelected3 = !_isSelected3;
                });
              },
            ),
          ),
          Center(
              child: Text(
            "SelectMode.check with bottomDescription",
            style: TextStyle(fontSize: 20.0),
          )),
          Center(
            child: SelectableCircle(
              color: Colors.redAccent,
              borderColor: Colors.red,
              isSelected: _isSelected4,
              selectMode: SelectMode.check,
              bottomDescription: Text("Description"),
              width: 80.0,
              child: Icon(
                Icons.tag_faces,
                size: 40.0,
              ),
              onTap: () {
                setState(() {
                  _isSelected4 = !_isSelected4;
                });
              },
            ),
          ),
          Center(
              child: Text(
            "SelectMode.check with custom colors",
            style: TextStyle(fontSize: 20.0),
          )),
          Center(
            child: SelectableCircle(
              color: Colors.redAccent,
              borderColor: Colors.red,
              isSelected: _isSelected5,
              selectMode: SelectMode.check,
              selectedColor: Colors.white,
              selectedBorderColor: Colors.blue,
              width: 80.0,
              child: Icon(
                Icons.watch_later,
                size: 40.0,
              ),
              onTap: () {
                setState(() {
                  _isSelected5 = !_isSelected5;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
