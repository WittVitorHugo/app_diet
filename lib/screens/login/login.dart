import 'package:flutter/material.dart';

import 'localwidgets/login_form.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: const <Widget>[
                SizedBox(height: 20.0,),
                LoginFormPage(),
              ],
            ),

          ),
        ],
      ),
    );
  }
}
