import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/models/person_model.dart';
import 'person_card.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({Key key}) : super(key: key);

  @override
  _LocalJsonState createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {

  static int counter = 0;
  
  List<Person> personList = List<Person>();
  final String localJsonPath = 'assets/dummy_data.json';

  Future<void> loadLocalJson() async {
    var dummyData = await rootBundle.loadString(localJsonPath);
    List<dynamic> decodedJson = json.decode(dummyData);
    personList = decodedJson.map((user) => Person.fromMap(user)).toList();
    setState(() {
      return personList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadLocalJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: personList.length == 0
          ? const Center(child: const Text("Loading..."))
          : listItems(context, personList),
    );
  }

  Widget get appbar => AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
        title: const Text("Local Json"),
      );

  Widget listItems(BuildContext context, List<Person> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Dismissible(
          direction: DismissDirection.endToStart,
          background: background,
          key: Key(counter.toString()),
          onDismissed: (delete) {
            setState(() {
              counter++;
              personList.removeAt(index);
            });
          },
          child: PersonCard(
            email: list[index].email,
            name: list[index].name,
            username: list[index].username.substring(0, 1),
          ),
        );
      },
    );
  }

  Widget get background => Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            alignment: Alignment.centerRight,
            color: Colors.red,
            child: const Icon(
              Icons.delete_sweep,
              size: 35,
              color: Colors.white,
            ),
          );
}
