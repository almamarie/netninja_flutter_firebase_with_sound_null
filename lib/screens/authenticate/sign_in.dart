import 'package:flutter/material.dart';
import 'package:netninja_flutter_firebase/services/auth.dart';
import 'package:netninja_flutter_firebase/shared/constants.dart';
import 'package:netninja_flutter_firebase/shared/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleView}) : super(key: key);
  final Function toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text("Sign in to Brew Crew"),
              actions: [
                const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) {
                        return val!.isEmpty ? "Enter Email" : null;
                      },
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Password";
                        }
                        if (val.length < 8) {
                          return "Password length must be greater than 8";
                        }
                      },
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);

                            if (result == null) {
                              setState(() {
                                loading = false;
                              });
                              setState(() {
                                error = 'please supply a valid email';
                              });
                            }
                          }
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}


// TextButton(
//           child: const Text(
//             "Sign in anon",
//             style: TextStyle(color: Colors.black),
//           ),
//           onPressed: () async {
//             UserData result = await _auth.signInAnon();

//             if (result == null) {
//               print('error signing in');
//             } else {
//               print('signed in');
//               print("User ID ${result.uid}");
//             }
//           },
//         ),