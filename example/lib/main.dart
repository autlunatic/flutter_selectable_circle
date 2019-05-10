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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("example circle"),
      ),
      body: Column(
        children: <Widget>[
          Center(child: Text("Custom Colors")),
          Center(
            child: SelectableCircle(
              width: 80.0,
              isSelected: _isSelected2,
              color: Colors.brown,
              selectedBorderColor: Colors.orange,
              selectedColor: Colors.tealAccent,
              selectMode: SelectMode.simple,
              onSelected: () {
                setState(() {
                  _isSelected2 = !_isSelected2;
                });
              },
              child: Icon(Icons.star),
            ),
          ),
          Center(child: Text("default")),
          Center(
            child: SelectableCircle(
              width: 80.0,
              isSelected: _isSelected,
              onSelected: () {
                setState(() {
                  _isSelected = !_isSelected;
                });
              },
              child: Text("test"),
            ),
          ),
          Center(child: Text("empty Circle")),
          Center(
            child: SelectableCircle(
              isSelected: _isSelected3,
              width: 80.0,
              onSelected: () {
                setState(() {
                  _isSelected3 = !_isSelected3;
                });
              },
            ),
          ),
          Center(child: Text("empty Circle")),
          Center(
            child: SelectableCircle(
              color: Colors.redAccent,
              borderColor: Colors.red,
              isSelected: _isSelected4,
              selectMode: SelectMode.check,
              width: 80.0,
              child: Icon(
                Icons.tag_faces,
                size: 40.0,
              ),
              onSelected: () {
                setState(() {
                  _isSelected4 = !_isSelected4;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
