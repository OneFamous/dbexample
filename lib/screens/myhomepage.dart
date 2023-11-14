import 'package:dbexample/utils/dbhelper.dart';
import 'package:flutter/material.dart';

import '../models/car.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbHelper = DatabaseHelper.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController milesController = TextEditingController();

  void _showMessageInScaffold(String message) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } else {
      print("Uyarı: _scaffoldKey.currentContext null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Car App SQL"),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Insert",
                ),
                Tab(
                  text: "View",
                ),
                Tab(
                  text: "Query",
                ),
                Tab(
                  text: "Update",
                ),
                Tab(
                  text: "Delete",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Car Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: TextField(
                        controller: milesController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Car Miles',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Text("Insert Car Details"),
                      onPressed: () {
                        String name = nameController.text;
                        int milers = int.parse(milesController.text);
                        _insert(name, miles);
                      },
                    )
                  ],
                ),
              ),
              Container(),
              Center(),
              Center(),
              Center(),
            ],
          )),
    );
  }

  void _insert(String name, int miles) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnMiles: miles,
    };

    Car car = Car.fromMap(row);
    final id = await dbHelper.insert(car);
    _showMessageInScaffold('Inserted Row ID: $id');
  }
}
