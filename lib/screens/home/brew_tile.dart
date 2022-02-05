import 'package:flutter/material.dart';
import 'package:netninja_flutter_firebase/models/brew.dart';

class BrewTile extends StatelessWidget {
  const BrewTile({Key? key, required this.brew}) : super(key: key);

  final Brew brew;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
