import 'package:flutter/material.dart';
import 'package:netninja_flutter_firebase/models/user.dart';
import 'package:netninja_flutter_firebase/services/database.dart';
import 'package:netninja_flutter_firebase/shared/constants.dart';
import 'package:netninja_flutter_firebase/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

final _formKey = GlobalKey<FormState>();
final List<String> sugars = ['0', '1', '2', '3', '4'];

String _currentName = '';
String _currentSugars = '0';
int _currentStrength = 100;

class _SettingsFormState extends State<SettingsForm> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return StreamBuilder<UserDataNew>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserDataNew? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Update Your Brew Settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() {
                      _currentName = val;
                    }),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // dropdowm

                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    isExpanded: true,
                    value: _currentSugars == ' '
                        ? userData.sugars
                        : userData.sugars,
                    items: sugars.map(
                      (sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _currentSugars = val.toString();
                        },
                      );
                    },
                  ),

                  //slider

                  Slider(
                    activeColor: Colors.brown[_currentStrength],
                    inactiveColor: Colors.brown[_currentStrength],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    value: (_currentStrength).toDouble(),
                    onChanged: (val) {
                      setState(
                        () {
                          _currentStrength = val.round();
                        },
                      );
                    },
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.pink,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars,
                          _currentName,
                          _currentStrength,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
