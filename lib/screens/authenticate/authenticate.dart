import 'package:flutter/material.dart';
import 'package:netninja_flutter_firebase/screens/authenticate/register.dart';
import 'package:netninja_flutter_firebase/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showSignIn 
      ? SignIn(toggleView: toggleView) 
      : Register(toggleView: toggleView),
    );
  }
}
