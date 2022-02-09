import 'package:flutter/material.dart';
import 'package:netninja_flutter_firebase/screens/home/settings_form.dart';
import 'package:netninja_flutter_firebase/services/auth.dart';
import 'package:netninja_flutter_firebase/services/database.dart';
import 'package:provider/provider.dart';
import 'package:netninja_flutter_firebase/screens/home/brew_list.dart';

import '../../models/brew.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: const SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                dynamic result = await _auth.signOut();
                print(result);
              },
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    "logout",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            TextButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              label:
                  const Text('Settings', style: TextStyle(color: Colors.black)),
            )
          ],
        ),
        body: const BrewList(),
      ),
    );
  }
}
