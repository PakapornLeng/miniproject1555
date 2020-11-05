import 'package:firebasedemo/screens/authen.dart';
import 'package:firebasedemo/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class Login extends StatefulWidget {
  final String title;
  const Login({Key key, this.title}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('pic/3p.png'),
        )),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  GoogleSignInButton(
                      onPressed: () => signInwithGoogle().then((value) {
                            if (value != null) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => Homepage(),
                                  ),
                                  (route) => false);
                            }
                          })),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
