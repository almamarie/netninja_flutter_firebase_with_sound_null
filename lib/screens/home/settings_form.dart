import 'package:flutter/material.dart';
import 'package:netninja_flutter_firebase/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

final _formKey = GlobalKey<FormState>();
final List<String> sugars = ['0', '1', '2', '3', '4'];

String _currentName = '';
String _currentSugars = '';
int _currentStrength = 0;

class _SettingsFormState extends State<SettingsForm> {
  @override
  Widget build(BuildContext context) {
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
            decoration: textInputDecoration.copyWith(hintText: 'Name'),
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() {
              _currentName = val;
            }),
          ),
          const SizedBox(
            height: 20.0,
          ),
          // dropdowm

          DropdownButton(
              isExpanded: true,
              value: Text('$_currentSugars sugars'),
              items: sugars.map(
                (sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text('$sugar sugars'),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(() {
                  _currentSugars = val.toString();
                });
              }),

          //slider

          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.pink,
            ),
            onPressed: () async {
              print(_currentName);
              print(_currentStrength);
              print(_currentSugars);
            },
            child: const Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
