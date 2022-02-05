import 'package:flutter/material.dart';
import 'package:netninja_flutter_firebase/screens/authenticate/authenticate.dart';
import 'package:netninja_flutter_firebase/screens/home/home.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);

    // Return Either Home or Authenticaten Widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
