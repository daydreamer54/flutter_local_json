import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String username;
  final String name;
  final String email;
  const PersonCard({Key key, this.username, this.name, this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(username),
      ),
      title: Text(name),
      subtitle: Text(email),
    );
  }
}