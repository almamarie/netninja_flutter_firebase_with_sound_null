import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:netninja_flutter_firebase/models/user.dart';
import 'package:netninja_flutter_firebase/screens/wrapper.dart';
import 'package:netninja_flutter_firebase/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
